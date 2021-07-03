//
//  CDProduct+Convenience.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension CDProduct {
    convenience init(category: String,
                     count: Int16,
                     descriptionText: String,
                     discountPrice: Int16,
                     id: Int16,
                     image: String,
                     name: String,
                     price: Int16,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.category = category
        self.count = count
        self.descriptionText = descriptionText
        self.discountPrice = discountPrice
        self.id = id
        self.image = image
        self.name = name
        self.price = price
    }
}
