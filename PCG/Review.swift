//
//  Review.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

struct Review: Codable {
    var name: String
    var review: String
    
    internal init(name: String, review: String) {
        self.name = name
        self.review = review
    }
}
