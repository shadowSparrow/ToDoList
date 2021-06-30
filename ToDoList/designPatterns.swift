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
    //imageView.layer.borderWidth = 2
    //imageView.layer.borderColor = UIColor.brown.cgColor
}


func tableViewCellImageViewDesign(element: UIImageView) {
    
    let imageView = element
    imageView.layer.cornerRadius = 45
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = UIColor.brown.cgColor
    
}


func textFieldDesign(element: UITextField) {
    
    let textField = element
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 2
    textField.layer.borderColor = UIColor.brown.cgColor
    textField.backgroundColor = .black
    textField.textColor = .white
    textField.attributedPlaceholder = NSAttributedString(string: "tap your text here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])

}

func buttonDesign(element: UIButton) {
    let button = element
    button.layer.cornerRadius = 10
    //button.layer.borderWidth = 2
    //button.layer.borderColor = UIColor.brown.cgColor
}

func viewDesing(element: UIView) {
    let view = element
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.brown.cgColor
    
}
