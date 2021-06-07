//
//  Protocols.swift
//  ToDoList
//
//  Created by mac on 25.05.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import Foundation

protocol AddNewWordDelegate{
    
    func addWord(word:String)
    func isItemExist(item: String) -> Bool
    func shouldReplace(item: String, withItem newItem: String)
    
}
