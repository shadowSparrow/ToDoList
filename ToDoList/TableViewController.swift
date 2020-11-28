//
//  TableViewController.swift
//  ToDoList
//
//  Created by Alexander Romanenko on 01.09.2019.
//  Copyright © 2019 Alexander Romanenko. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var Add: UIBarButtonItem!
    @IBAction func addAction(_ sender: Any) {
        
    let alert = UIAlertController(title: "NewItem", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "NewItemName"
        }
        
        let action1 = UIAlertAction(title: "add", style: .default) { (action1) in
        
        let newItem = alert.textFields![0].text
        addItem(nameItem: newItem!, isCompleted: false)
        self.tableView.reloadData()
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        
    }
        
    
    @IBAction func edit(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return ToDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сellidentifier", for: indexPath)
        let currentItem = ToDoItems[indexPath.row]
        cell.textLabel?.text = currentItem ["Name"] as? String

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
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
       moveRow(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ToDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(item: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check1x")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named:"uncheck1x")
        }
}
}



