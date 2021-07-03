//
//  Fulfilled+CoreDataProperties.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension Fulfilled {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fulfilled> {
        return NSFetchRequest<Fulfilled>(entityName: "Fulfilled")
    }
    
    @NSManaged public var text: String?
    @NSManaged public var id: Int16
}
