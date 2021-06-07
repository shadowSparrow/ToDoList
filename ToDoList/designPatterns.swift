//
//  designPatterns.swift
//  ToDoList
//
//  Created by mac on 12.05.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import Foundation
import UIKit

func imageViewDesign (element: UIImageView) {
    
    let imageView = element
    imageView.layer.cornerRadius = 10
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.brown.cgColor
}


func textFieldDesign(element: UITextField) {
    
    let textField = element
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.brown.cgColor
    textField.backgroundColor = .black
    textField.textColor = .white
    textField.attributedPlaceholder = NSAttributedString(string: "tap here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])

}
