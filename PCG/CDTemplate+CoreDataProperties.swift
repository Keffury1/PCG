//
//  CDTemplate+CoreDataProperties.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension CDTemplate {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTemplate> {
        return NSFetchRequest<CDTemplate>(entityName: "CDTemplate")
    }
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var fulfilled: NSSet?
    
    public var fulfilledArray: [Fulfilled] {
        let set = fulfilled as? Set<Fulfilled> ?? []
        return set.sorted { full1, full2 in
            full1.id > full2.id
        }
    }
}

extension CDTemplate {
    
    @objc(addFulfilledObject:)
    @NSManaged public func addToFulfilled(_ value: Fulfilled)

    @objc(removeFulfilledObject:)
    @NSManaged public func removeFromFulfilled(_ value: Fulfilled)

    @objc(addTemplate:)
    @NSManaged public func addToFulfilled(_ values: NSSet)

    @objc(removeTemplates:)
    @NSManaged public func removeFromFulfilled(_ values: NSSet)
}
