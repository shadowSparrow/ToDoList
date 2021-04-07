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
    
    @IBOutlet weak var Add: UIBarButtonItem!
    
    var items: [List]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addAction(_ sender: Any) {
        
    let alert = UIAlertController(title: "NewItem", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "NewItemName"
        }
        
        let action1 = UIAlertAction(title: "add", style: .default) { (action1) in
        
        let newItem = alert.textFields![0]
            let item = List(context: self.context)
            
            item.item = newItem.text
            
            // SaveItem
            try! self.context.save()
            
            //RefetchItems
            self.fetchItems()
            
            //addItem(nameItem: newItem!, isCompleted: false)
        //self.tableView.reloadData()
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        
    }
    
    override func viewDidLoad() {
        fetchItems()
    }
        
    func fetchItems() {
        items = try! context.fetch(List.fetchRequest())
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
   
   /*
    func moveRow(fromIndex: Int, toIndex: Int) {
        let from = items![fromIndex]
        items!.remove(at: fromIndex)
        items!.insert(from, at: toIndex)
    }
    
*/
    @IBAction func edit(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return items!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сellidentifier", for: indexPath)
        let currentItem = items![indexPath.row]
        //let currentItem = items![indexPath.row]
        cell.textLabel?.text = currentItem.item
            //currentItem ["Name"] as? String
        return cell
        
        
    
        /*
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "check1x")
        } else {
            cell.imageView?.image = UIImage(named: "uncheck1x")
        }
            if tableView.isEditing {
                cell.textLabel?.alpha = 0.4
                cell.imageView?.alpha = 0.4
            } else {
                cell.textLabel?.alpha = 1
                cell.imageView?.alpha = 1
        }*/
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    

    /*
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "delete") { (action, view, handler) in
            let itemToRemove = self.items![indexPath.row]
            self.context.delete(itemToRemove)
            try! self.context.save()
            self.fetchItems()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    */
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let itemToRemove = items![indexPath.row]
            self.context.delete(itemToRemove)
            try! self.context.save()
            self.fetchItems()
            
        } else if editingStyle == .insert {
        }    
    }
 
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
       
//        let selectedItem = items![indexPath.row]
        var selectedItem = items![indexPath.row]
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        textField.text = selectedItem.item
        
        let action = UIAlertAction(title: "SaveButton", style: .default) { (alertAction) in
            
            let textField = alert.textFields![0]
            selectedItem.item = textField.text
           
            try! self.context.save()
            self.fetchItems()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        /*
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(item: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check1x")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named:"uncheck1x")
        }
        */
}
    
    
    
}



