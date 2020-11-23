//
//  Model.swift
//  ToDoList
//
//  Created by Alexander Romanenko on 01.09.2019.
//  Copyright © 2019 Alexander Romanenko. All rights reserved.
//

import Foundation


// Save changes with UserDefault
var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoItems")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoItems") as? [[String:Any]]
        {
            return array
            
        } else {
            return []
        }
    }
    
    
}
    

func addItem (nameItem: String, isCompleted: Bool = false) {
    
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    
}

func removeItem (index: Int) {
    
    ToDoItems.remove(at: index)
    
}

func moveRow(fromIndex: Int, toIndex: Int) {
    
    let from = ToDoItems[fromIndex]
    
    ToDoItems.remove(at: fromIndex)
    
    ToDoItems.insert(from, at: toIndex)
}

func changeState(item: Int) -> Bool {
    
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    
    return ToDoItems[item]["isCompleted"] as! Bool
    
    
}

