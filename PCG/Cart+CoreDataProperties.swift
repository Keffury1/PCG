//
//  Cart+CoreDataProperties.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension Cart {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }
    
    @NSManaged public var cartProducts: NSSet?
    @NSManaged public var name: String?
    
    
    public var cartArray: [CDProduct] {
        let set = cartProducts as? Set<CDProduct> ?? []
        return set.sorted { (item1, item2) -> Bool in
            item1.id > item2.id
        }
    }
}

extension Cart {
    
    @objc(addCartProductsObject:)
    @NSManaged public func addToCartProducts(_ value: CDProduct)

    @objc(removeFulfilledObject:)
    @NSManaged public func removeFromCartProducts(_ value: CDProduct)

    @objc(addProducts:)
    @NSManaged public func addToCartProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeCartProducts(_ values: NSSet)
}
