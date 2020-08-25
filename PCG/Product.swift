//
//  Product.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    var title: String
    var price: String
    var image: UIImage
    
    internal init(title: String, price: String, image: UIImage) {
        self.title = title
        self.price = price
        self.image = image
    }
}
