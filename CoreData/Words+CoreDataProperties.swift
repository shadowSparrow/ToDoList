//
//  Words+CoreDataProperties.swift
//  ToDoList
//
//  Created by mac on 01.05.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//
//

import Foundation
import CoreData


extension Words {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Words> {
        return NSFetchRequest<Words>(entityName: "Words")
    }

    @NSManaged public var index: Int64
    @NSManaged public var name: String?
    @NSManaged public var translation: String?
    @NSManaged public var image: Data?

}
