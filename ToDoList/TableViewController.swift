//
//  TableViewController.swift
//  ToDoList
//
//  Created by Alexander Romanenko on 01.09.2019.
//  Copyright © 2019 Alexander Romanenko. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 14.0, *)
class TableViewController: UITableViewController {
    
   //MARK: - IBoutlets
    @IBOutlet weak var Add: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
        // MARK: - CoreDataProperties
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var CoreDataArray: [Words]?

    
    override func viewDidLoad() {
    
        self.title = "WordList"
    
        // MARK: - TableViewLook
        self.tableView.tintColor = .white
        let backgroundImage = UIImage(named: "secondBackGround")
        self.tableView.backgroundView = UIImageView(image: backgroundImage)
        self.tableView.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchItems()
        
        UIView.animate(withDuration: 1, animations: {
            //tableView.visibleCells
        }, completion: nil)
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
    
    @IBAction func editButtonAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let ThirdVC = mainStoryboard.instantiateViewController(withIdentifier: "ThirdVC") as? WordsCard
        
        ThirdVC?.color = .black
        ThirdVC?.addWordDelegate = self
        self.navigationController?.pushViewController(ThirdVC!,animated: true)
    }
    
    @IBAction func translationOnOff(_ sender: Any) {
    }
    
    
    // MARK: - TableViewDataSourceAndDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        guard CoreDataArray != nil else {return 0}
        return  CoreDataArray!.count //array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сellidentifier", for: indexPath) as! WordsTableCell
        
        guard CoreDataArray != nil else {return cell}
       
        try! context.save()
        let storedWords = CoreDataArray![indexPath.row]
        
        
        cell.cellSegmentedControl.isHidden = true
        cell.wordCellImageView.image = UIImage(data: storedWords.image!)
        tableViewCellImageViewDesign(element: cell.wordCellImageView)
        cell.wordCellWordLabel.text = storedWords.name
        cell.wordCellTranslationLabel.text = storedWords.translation
    
        return cell
    
}

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1*Double(indexPath.row)) {
            cell.alpha = 0
            cell.alpha = 1
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! WordsTableCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "ThirdVC") as? WordsCard
        
        nextVC?.addWordDelegate = self
        nextVC?.editedtext = cell.wordCellWordLabel.text
        nextVC?.editedTranlation = cell.wordCellTranslationLabel.text
        nextVC?.editedImage = cell.wordCellImageView.image
        
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
        return 100
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}






// MARK: - AddNewWordDelegateExtension
@available(iOS 14.0, *)
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
    
    func imageReplace(image: Data, newImage: Data) {
        
        for i in CoreDataArray! {
            if i.image == image {
                i.image = newImage
            } else {
                print("No such Image")
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
        
    func isItemExist(item: String, translation: String, image: Data) -> Bool {
    
    var bool: Bool?
    
    for name in CoreDataArray! {
        if name.name == item && name.translation == translation && name.image == image {
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

