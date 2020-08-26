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
    var products: [Product] = [Product(title: "Cottage Ornament", price: 20, image: UIImage.init(named: "Cottage Ornament")!, category: .Ornament),
                               Product(title: "Dog Treat Jar", price: 21, image: UIImage.init(named: "Dog Treat Jar")!, category: .Misc),
                               Product(title: "Welcome Mat", price: 22, image: UIImage.init(named: "Doormat")!, category: .Doormat),
                               Product(title: "Glass Cutting Board", price: 23, image: UIImage.init(named: "Glass Cutting Board")!, category: .CuttingBoard),
                               Product(title: "Glass Ornament", price: 24, image: UIImage.init(named: "Glass Ornament")!, category: .Ornament),
                               Product(title: "Knife Set", price: 25, image: UIImage.init(named: "Knife Set")!, category: .KnifeSet),
                               Product(title: "Lantern", price: 26, image: UIImage.init(named: "Lantern")!, category: .Misc),
                               Product(title: "Maple Cutting Board", price: 27, image: UIImage.init(named: "Maple Cutting Board")!, category: .CuttingBoard),
                               Product(title: "Marble Cheese Board", price: 28, image: UIImage.init(named: "MarbleWood Cutting Board")!, category: .CheeseBoard),
                               Product(title: "Open House Doormat", price: 29, image: UIImage.init(named: "Realtor Doormat")!, category: .Doormat),
                               Product(title: "Slate Cheese Board", price: 30, image: UIImage.init(named: "Slate Cheese Board")!, category: .CheeseBoard),
                               Product(title: "Stamps", price: 31, image: UIImage.init(named: "Stamp")!, category: .Misc),
                               Product(title: "Steak Knife Set", price: 32, image: UIImage.init(named: "Steak Knife Set")!, category: .KnifeSet),
                               Product(title: "3 Tool Cheese Board", price: 33, image: UIImage.init(named: "Three Tool")!, category: .CheeseBoard)]
}
