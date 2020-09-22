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
    var products: [Product] = [Product(title: "Cottage Ornament", description: "Give your client a charming wooden cottage to commemorate the purchase of their home.", price: 28.99, image: UIImage.init(named: "Cottage Ornament")!, category: .Ornament, count: 0),
                               Product(title: "Dog Treat Jar", description: "Give your Client’s Furry Friend a special treat on closing day. This refillable treat jar is personalized with your client’s pup’s name and comes with 18 matching peanut butter personalized cookies!", price: 38.75, image: UIImage.init(named: "Dog Treat Jar")!, category: .DogTreatJar, count: 0),
                               Product(title: "Welcome Mat", description: "", price: 43.99, image: UIImage.init(named: "Doormat")!, category: .Doormat, count: 0),
                               Product(title: "Glass Cutting Board", description: "These exclusive cutting boards are antibacterial, shatter resistant and can be used with all food types. When they’re not busy preparing the daily meal, these beautiful cutting boards will be displayed as kitchen décor.", price: 41.75, image: UIImage.init(named: "Glass Cutting Board")!, category: .CuttingBoard, count: 0),
                               Product(title: "Glass Ornament", description: "", price: 29.15, image: UIImage.init(named: "Glass Ornament")!, category: .Ornament, count: 0),
                               Product(title: "Knife Set", description: "The Santoku knives are hand forged in Germany with the highest quality carbon stainless steel for exceptional durability. Each blade is laser precision measured to guarantee world class sharpness.", price: 194.75, image: UIImage.init(named: "Knife Set")!, category: .KnifeSet, count: 0),
                               Product(title: "Lantern", description: "Be the focal point of your client’s home with our captivating personalized rustic lanterns. The delightful flicker of a candle illuminates your client’s name.", price: 68.88, image: UIImage.init(named: "Lantern")!, category: .Lantern, count: 0),
                               Product(title: "Maple Cutting Board", description: "Maple wood, which is light in color and full of subtle grain marks, makes an excellent complement to your client’s kitchen. Maple is a hard wood which resists scarring and provides a natural protection against microbial contamination.", price: 61.99, image: UIImage.init(named: "Maple Cutting Board")!, category: .CuttingBoard, count: 0),
                               Product(title: "Marble Cheese Board", description: "With classic white marble on top and acacia wood on the bottom, these gorgeous cheese boards or coaster sets are the perfect home décor addition", price: 69.15, image: UIImage.init(named: "MarbleWood Cutting Board")!, category: .CheeseBoard, count: 0),
                               Product(title: "Open House Doormat", description: "Each open house doormat is made from a tufted looped polyester with a non-skid rubberized backing and black edges. Your design is printed into the mat, which creates a durable, weather-resistant image that lasts!", price: 59.76, image: UIImage.init(named: "Realtor Doormat")!, category: .Doormat, count: 0),
                               Product(title: "Slate Cheese Board", description: "Our charcoal slate products offer a beautifully rustic, organic surface to match any type of household. From a farmhouse styled home to a bachelor pad, these slate products are sure to make a statement. ", price: 59.55, image: UIImage.init(named: "Slate Cheese Board")!, category: .CheeseBoard, count: 0),
                               Product(title: "Stamps", description: "Our self-inking address stamps last for thousands of impressions and are a much-needed gift that your client will use on a regular basis.", price: 35.99, image: UIImage.init(named: "Stamp")!, category: .Stamps, count: 0),
                               Product(title: "Steak Knife Set", description: "Made in France, these knives were inspired by pocket knives used by French Shepherds 200 years ago. Each blade is made from high quality stainless steel, light weight acrylic handle (Ivory) with a beautiful Platine detailing down the spine.", price: 124.75, image: UIImage.init(named: "Steak Knife Set")!, category: .KnifeSet, count: 0),
                               Product(title: "3 Tool Cheese Board", description: "The bamboo is topped by a tempered Pyrex cutting board that is conveniently removable, so it can double as a serving tray. There is no need to go back to the kitchen for a cheese knife. Simply pull out the 'hidden' drawer and you'll find 3 varieties of cheese tools ready to use.", price: 88.99, image: UIImage.init(named: "Three Tool")!, category: .CheeseBoard, count: 0)]
}
