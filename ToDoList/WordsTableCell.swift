//
//  WordsTableCell.swift
//  WordList
//
//  Created by mac on 20.06.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//
import Foundation
import UIKit

class WordsTableCell: UITableViewCell {
    
    @IBOutlet weak var wordCellImageView: UIImageView!
    @IBOutlet weak var wordCellWordLabel: UILabel!
    @IBOutlet weak var wordCellTranslationLabel: UILabel!
    
    @IBOutlet weak var cellSegmentedControl: UISegmentedControl!
    
     //imageView.layer.borderWidth = 2
    //imageView.layer.borderColor = UIColor.brown.cgColor
    
}


