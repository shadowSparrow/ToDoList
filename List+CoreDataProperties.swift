//
//  List+CoreDataProperties.swift
//  ToDoList
//
//  Created by mac on 07.04.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var item: String?

}
