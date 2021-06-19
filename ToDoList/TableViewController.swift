//
//  TableViewController.swift
//  ToDoList
//
//  Created by Alexander Romanenko on 01.09.2019.
//  Copyright © 2019 Alexander Romanenko. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
   //MARK: - IBoutlets
    @IBOutlet weak var Add: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK: - CoreDataProperties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var CoreDataArray: [Words]?

    
    override func viewDidLoad() {
    
        // MARK: - TableViewLook
        self.tableView.tintColor = .white
        let backgroundImage = UIImage(named: "secondBackGround")
        self.tableView.backgroundView = UIImageView(image: backgroundImage)
        self.tableView.backgroundColor = .black
        //navigationBar.isHidden = true
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchItems()
        
    }
    

    // MARK: - CoreDataMethodes
    func fetchItems() {
        let request = Words.fetchRequest() as NSFetchRequest<Words>
        let sort = NSSortDescriptor(key: "index", ascending: false)
        request.sortDescriptors = [sort]
        CoreDataArray = try! context.fetch(request)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
 
    // MARK: - IBActions
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
    }
    @IBAction func addAction(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let ThirdVC = mainStoryboard.instantiateViewController(withIdentifier: "ThirdVC") as? WordsCard
        
        ThirdVC?.color = .black
        ThirdVC?.addWordDelegate = self
        self.navigationController?.pushViewController(ThirdVC!,animated: true)
    
    }
   
    // MARK: - TableViewDataSourceAndDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        guard CoreDataArray != nil else {return 0}
        return  CoreDataArray!.count //array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сellidentifier", for: indexPath)
        
        guard CoreDataArray != nil else {return cell}
       
        try! context.save()
        let storedWords = CoreDataArray![indexPath.row]
        
        cell.textLabel?.text = storedWords.name
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.text = storedWords.translation
        if storedWords.image != nil {
        let image = UIImage(data: storedWords.image!)
            cell.imageView?.image = image
        }
        return cell
    
}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC") as? WordsCard
        nextVC?.addWordDelegate = self
        //nextVC?.isHidden = true
        guard cell?.textLabel?.text != "" else {return}
        nextVC?.editedtext = (cell?.textLabel?.text)!
        nextVC?.editedTranlation = cell?.detailTextLabel?.text
        nextVC?.image = cell?.imageView?.image!
        
        show(nextVC!, sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard CoreDataArray != nil else {return}
        let movedWord = CoreDataArray![sourceIndexPath.row]
        CoreDataArray?.remove(at: sourceIndexPath.row)
        CoreDataArray?.insert(movedWord, at: destinationIndexPath.row)
        try! context.save()
        
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   
            if editingStyle == .delete {
                let wordToRemove = CoreDataArray![indexPath.row]
                self.context.delete(wordToRemove)
                try! self.context.save()
                self.fetchItems()
                
            } else if editingStyle == .insert {
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}






// MARK: - AddNewWordDelegateExtension
extension TableViewController: AddNewWordDelegate {
    
    func addWord(word: String, translation: String) {
    }
    
    
    
    func addImage(image: Data) {
        
        if image != nil {
            let newWord = Words(context: context)
            newWord.image = image
            CoreDataArray?.append(newWord)
            try!context.save()
        }
    }
    
   

    func deleteItem(name: String) {
        
        for i in CoreDataArray! {
            if i.name == name {
                context.delete(i)
            }
        }
    }
    
    
    func translationReplace(translation: String, with newTranslation: String) {
       
        for i in CoreDataArray! {
            if i.translation == translation {
                print("itExist")
                i.translation = newTranslation
            } else {
                print("NoSuchAlement")
            }
        }
    }
    
    func shouldReplace(item: String, withItem newItem: String) {
        for i in CoreDataArray! {
            
            if i.name == item {
                print("ItExists")
                i.name = newItem
            
            
            }
            else {
                print("NoSuchAElement")
            }
        }
    }
        
    func isItemExist(item: String, translation: String) -> Bool {
    
    var bool: Bool?
    //guard bool != nil else {return false}
    for name in CoreDataArray! {
        if name.name == item && name.translation == translation {
    bool = true
        } else {
            bool = false
        }
    }
    guard bool != nil else {return false}
    return bool!
}

    func addWord(word: String, translation: String, image: Data) {
        let newWord = Words(context: context)
        newWord.name = word
        newWord.translation = translation
        newWord.image = image
        CoreDataArray?.append(newWord)
         try! context.save()
        tableView.reloadData()
    }
}

