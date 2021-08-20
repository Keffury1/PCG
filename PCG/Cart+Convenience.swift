//
//  Cart+Convenience.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension Cart {
    convenience init(name: String,
                     notes: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.notes = notes
    }
}
