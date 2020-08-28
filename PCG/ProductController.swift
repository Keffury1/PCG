//
//  ProductController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

class ProductController {
    var products: [Product] = [Product(title: "Cottage Ornament", price: 29, image: UIImage.init(named: "Cottage Ornament")!, category: .Ornament),
                               Product(title: "Dog Treat Jar", price: 39, image: UIImage.init(named: "Dog Treat Jar")!, category: .DogTreatJar),
                               Product(title: "Welcome Mat", price: 44, image: UIImage.init(named: "Doormat")!, category: .Doormat),
                               Product(title: "Glass Cutting Board", price: 42, image: UIImage.init(named: "Glass Cutting Board")!, category: .CuttingBoard),
                               Product(title: "Glass Ornament", price: 29, image: UIImage.init(named: "Glass Ornament")!, category: .Ornament),
                               Product(title: "Knife Set", price: 195, image: UIImage.init(named: "Knife Set")!, category: .KnifeSet),
                               Product(title: "Lantern", price: 69, image: UIImage.init(named: "Lantern")!, category: .Lantern),
                               Product(title: "Maple Cutting Board", price: 62, image: UIImage.init(named: "Maple Cutting Board")!, category: .CuttingBoard),
                               Product(title: "Marble Cheese Board", price: 69, image: UIImage.init(named: "MarbleWood Cutting Board")!, category: .CheeseBoard),
                               Product(title: "Open House Doormat", price: 59, image: UIImage.init(named: "Realtor Doormat")!, category: .Doormat),
                               Product(title: "Slate Cheese Board", price: 59, image: UIImage.init(named: "Slate Cheese Board")!, category: .CheeseBoard),
                               Product(title: "Stamps", price: 35, image: UIImage.init(named: "Stamp")!, category: .Stamps),
                               Product(title: "Steak Knife Set", price: 125, image: UIImage.init(named: "Steak Knife Set")!, category: .KnifeSet),
                               Product(title: "3 Tool Cheese Board", price: 88, image: UIImage.init(named: "Three Tool")!, category: .CheeseBoard)]
}
