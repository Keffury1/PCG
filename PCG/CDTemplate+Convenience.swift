//
//  CDTemplate+Convenience.swift
//  PCG
//
//  Created by Bobby Keffury on 7/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import CoreData

extension CDTemplate {
    convenience init(id: Int16,
                     name: String,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.name = name
    }
}
