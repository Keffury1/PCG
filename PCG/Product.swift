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
    var description: String
    var price: Double
    var image: UIImage
    var blankImage: UIImage?
    var category: Categories
    var count: Int
    var templates: [Template]?
    
    internal init(title: String, description: String, price: Double, image: UIImage, blankImage: UIImage? = nil, category: Categories, count: Int, templates: [Template]? = nil) {
        self.title = title
        self.description = description
        self.price = price
        self.image = image
        self.blankImage = blankImage
        self.category = category
        self.count = count
        self.templates = templates
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
