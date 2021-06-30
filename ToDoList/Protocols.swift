//
//  Protocols.swift
//  ToDoList
//
//  Created by mac on 25.05.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import Foundation
import UIKit

protocol AddNewWordDelegate {
    
    func addWord(word:String, translation: String, image: Data)
    //func addImage(image:UIImage)
    func isItemExist(item: String, translation: String, image: Data) -> Bool
    func shouldReplace(item: String, withItem newItem: String)
    func translationReplace(translation: String, with newTranslation: String)
    
    func imageReplace(image: Data, newImage: Data)
    func deleteItem(name: String)
}
