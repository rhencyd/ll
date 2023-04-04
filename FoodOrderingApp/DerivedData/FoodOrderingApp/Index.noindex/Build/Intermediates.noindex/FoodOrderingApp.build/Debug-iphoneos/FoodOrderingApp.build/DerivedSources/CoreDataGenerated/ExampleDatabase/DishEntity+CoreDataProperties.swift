//
//  DishEntity+CoreDataProperties.swift
//  
//
//  Created by Rhency Delgado on 4/3/23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension DishEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DishEntity> {
        return NSFetchRequest<DishEntity>(entityName: "DishEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?

}

extension DishEntity : Identifiable {

}
