//
//  Product.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

struct Product: Codable {
    var title: String
    var description: String
    var price: Double
    var fiveUnitPrice: Double
    var tenUnitPrice: Double
    var twentyUnitPrice: Double
    var image: String
    var category: Categories
    var count: Int
    var templates: [Template]?
    var chosenTemplate: Template?
    
    internal init(title: String, description: String, price: Double, fiveUnitPrice: Double, tenUnitPrice: Double, twentyUnitPrice: Double, image: String, category: Categories, count: Int, templates: [Template]? = nil, chosenTemplate: Template? = nil) {
        self.title = title
        self.description = description
        self.price = price
        self.fiveUnitPrice = fiveUnitPrice
        self.tenUnitPrice = tenUnitPrice
        self.twentyUnitPrice = twentyUnitPrice
        self.image = image
        self.category = category
        self.count = count
        self.templates = templates
        self.chosenTemplate = chosenTemplate
    }
}

enum Categories: Int, Codable {
    case CuttingBoard = 1
    case CheeseBoard = 2
    case KnifeSet = 3
    case Ornament = 4
    case Doormat = 5
    case Lantern = 6
    case DogTreatJar = 7
    case Stamps = 8
}
