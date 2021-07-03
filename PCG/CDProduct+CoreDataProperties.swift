//
//  CDProduct+CoreDataProperties.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension CDProduct {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }
    
    @NSManaged public var category: String?
    @NSManaged public var count: Int16
    @NSManaged public var descriptionText: String?
    @NSManaged public var discountPrice: Int16
    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int16
    @NSManaged public var chosenTemplate: NSSet?
    
    public var chosenArray: [CDTemplate] {
        let set = chosenTemplate as? Set<CDTemplate> ?? []
        return set.sorted { temp1, temp2 in
            temp1.id > temp2.id
        }
    }
}

extension CDProduct {
    
    @objc(addChosenTemplateObject:)
    @NSManaged public func addToChosenTemplate(_ value: CDTemplate)

    @objc(removeChosenTemplateObject:)
    @NSManaged public func removeFromChosenTemplate(_ value: CDTemplate)

    @objc(addChosenTemplate:)
    @NSManaged public func addToChosenTemplate(_ values: NSSet)

    @objc(removeChosenTemplate:)
    @NSManaged public func removeFromChosenTemplate(_ values: NSSet)
}
