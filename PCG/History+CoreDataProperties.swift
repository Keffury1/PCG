//
//  History+CoreDataProperties.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension History {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }
    
    @NSManaged public var historyProducts: NSSet?
    @NSManaged public var name: String?
    
    public var historyArray: [CDProduct] {
        let set = historyProducts as? Set<CDProduct> ?? []
        return set.sorted { (item1, item2) -> Bool in
            item1.id > item2.id
        }
    }
}

extension History {
    
    @objc(addHistoryProductsObject:)
    @NSManaged public func addToHistoryProducts(_ value: CDProduct)

    @objc(removeHistoryProductsObject:)
    @NSManaged public func removeFromHistoryProducts(_ value: CDProduct)

    @objc(addHistoryProducts:)
    @NSManaged public func addToHistoryProducts(_ values: NSSet)

    @objc(removeHistoryProducts:)
    @NSManaged public func removeFromHistoryProducts(_ values: NSSet)
}
