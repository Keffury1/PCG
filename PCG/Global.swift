//
//  Global.swift
//  PCG
//
//  Created by Bobby Keffury on 9/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

class Global {
    private init() { }
    static let sharedInstance = Global()
    var cart = [Product]().sorted { (p1, p2) -> Bool in
        p1.price > p2.price
    }
}
