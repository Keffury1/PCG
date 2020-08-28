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
    var price: Int
    var image: UIImage
    var category: Categories
    
    internal init(title: String, price: Int, image: UIImage, category: Categories) {
        self.title = title
        self.price = price
        self.image = image
        self.category = category
    }
}

enum Categories: Int {
    case CuttingBoard = 1
    case CheeseBoard = 2
    case KnifeSet = 3
    case Ornament = 4
    case Doormat = 5
    case Lantern = 6
    case DogTreatJar = 7
    case Stamps = 8
}
