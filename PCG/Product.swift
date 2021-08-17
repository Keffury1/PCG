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
    var id: Int
    var name: String
    var image: String
    var category: String
    var price: Int
    var discountPrice: Int
    var description: String
    var count: Int
    var templates: [Template]?
    var chosenTemplate: [Template]?
    var customPhoto: Bool
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
