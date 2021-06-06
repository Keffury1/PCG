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
    var products: [Product] = [Product(title: "Cottage Ornament", description: "Give your client a charming wooden cottage to commemorate the purchase of their home.", price: 29.95, fiveUnitPrice: 26.9, tenUnitPrice: 25.75, twentyUnitPrice: 24.85, image: "Cottage Ornament", category: .Ornament, count: 0),
                               Product(title: "Dog Treat Jar", description: "Give your Client’s Furry Friend a special treat on closing day. This refillable treat jar is personalized with your client’s pup’s name and comes with 18 matching peanut butter personalized cookies!", price: 39.95, fiveUnitPrice: 38.95, tenUnitPrice: 37.95, twentyUnitPrice: 35.80, image: "Dog Treat Jar", category: .DogTreatJar, count: 0),
                               Product(title: "Welcome Mat", description: "", price: 43.99, fiveUnitPrice: 40, tenUnitPrice: 35, twentyUnitPrice: 30, image: "Doormat", category: .Doormat, count: 0),
                               Product(title: "Glass Cutting Board", description: "These exclusive cutting boards are antibacterial, shatter resistant and can be used with all food types. When they’re not busy preparing the daily meal, these beautiful cutting boards will be displayed as kitchen décor.", price: 42, fiveUnitPrice: 39.50, tenUnitPrice: 36.75, twentyUnitPrice: 35.15, image: "Glass Cutting Board", category: .CuttingBoard, count: 0),
                               Product(title: "Glass Ornament", description: "", price: 29.15, fiveUnitPrice: 27, tenUnitPrice: 25, twentyUnitPrice: 20, image: "Glass Ornament", category: .Ornament, count: 0),
                               Product(title: "Knife Set", description: "The Santoku knives are hand forged in Germany with the highest quality carbon stainless steel for exceptional durability. Each blade is laser precision measured to guarantee world class sharpness.", price: 195.25, fiveUnitPrice: 192.75, tenUnitPrice: 189, twentyUnitPrice: 184.25, image: "Knife Set", category: .KnifeSet, count: 0),
                               Product(title: "Lantern", description: "Be the focal point of your client’s home with our captivating personalized rustic lanterns. The delightful flicker of a candle illuminates your client’s name.", price: 69.95, fiveUnitPrice: 64.95, tenUnitPrice: 59.95, twentyUnitPrice: 57, image: "Lantern", category: .Lantern, count: 0),
                               Product(title: "Maple Cutting Board", description: "Maple wood, which is light in color and full of subtle grain marks, makes an excellent complement to your client’s kitchen. Maple is a hard wood which resists scarring and provides a natural protection against microbial contamination.", price: 62.50, fiveUnitPrice: 56.90, tenUnitPrice: 52.99, twentyUnitPrice: 50.85, image: "Maple Cutting Board", category: .CuttingBoard, count: 0, templates: [
                                        Template(image: "Maple3LTR", needs: [.initials, .date], fulfilled: []),
                                                                                                           
                                        Template(image: "MapleAntler", needs: [.initials, .date], fulfilled: []),
                                                                                                                                      
                                        Template(image: "MapleBold", needs: [.firstName, .firstName, .lastName, .lastInitial, .date], fulfilled: []),
                                        
                                        Template(image: "MapleChampagne", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleElegant", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleF&F", needs: [.address, .date], fulfilled: []),
                                        
                                        Template(image: "MapleHome", needs: [.state, .firstName, .firstName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleHSH", needs: [.firstName, .firstName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleImpact", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleKey", needs: [.firstName, .firstName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleLeaf", needs: [.firstName, .firstName, .lastName], fulfilled: []),
                                        
                                        Template(image: "MapleRustic", needs: [.date, .lastName], fulfilled: []),
                                        
                                        Template(image: "MapleScript", needs: [.initials, .date], fulfilled: []),
                                        
                                        Template(image: "MapleVisionary", needs: [.lastName, .date], fulfilled: []),
                                        
                                        Template(image: "MapleWhimsical", needs: [.firstName, .firstName, .lastName, .date], fulfilled: [])]),
                               Product(title: "Marble Cheese Board", description: "With classic white marble on top and acacia wood on the bottom, these gorgeous cheese boards or coaster sets are the perfect home décor addition", price: 69.95, fiveUnitPrice: 65.45, tenUnitPrice: 62.95, twentyUnitPrice: 59.5, image: "MarbleWood Cutting Board", category: .CheeseBoard, count: 0),
                               Product(title: "Open House Doormat", description: "Each open house doormat is made from a tufted looped polyester with a non-skid rubberized backing and black edges. Your design is printed into the mat, which creates a durable, weather-resistant image that lasts!", price: 59.95, fiveUnitPrice: 51.45, tenUnitPrice: 48.15, twentyUnitPrice: 45.75, image: "Realtor Doormat", category: .Doormat, count: 0),
                               Product(title: "Slate Cheese Board", description: "Our charcoal slate products offer a beautifully rustic, organic surface to match any type of household. From a farmhouse styled home to a bachelor pad, these slate products are sure to make a statement. ", price: 59.55, fiveUnitPrice: 52.45, tenUnitPrice: 49.95, twentyUnitPrice: 47.30, image: "Slate Cheese Board", category: .CheeseBoard, count: 0, templates: [Template(image: "Slate3LTR", needs: [.initials, .date], fulfilled: []),Template(image: "SlateAntler", needs: [.initials, .date], fulfilled: []), Template(image: "SlateBold", needs: [.firstName, .firstName, .lastName, .lastInitial, .date], fulfilled: []), Template(image: "SlateChampagne", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []), Template(image: "SlateElegant", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []), Template(image: "SlateF&F", needs: [.address, .date], fulfilled: []), Template(image: "SlateHome", needs: [.state, .firstName, .firstName, .date], fulfilled: []), Template(image: "SlateHSH", needs: [.firstName, .firstName, .date], fulfilled: []), Template(image: "SlateImpact", needs: [.firstName, .firstName, .lastName, .date], fulfilled: []), Template(image: "SlateKey", needs: [.firstName, .firstName, .date], fulfilled: []), Template(image: "SlateLeaf", needs: [.firstName, .firstName, .lastName], fulfilled: []), Template(image: "SlateRustic", needs: [.date, .lastName], fulfilled: []), Template(image: "SlateScript", needs: [.initials, .date], fulfilled: []), Template(image: "SlateVisionary", needs: [.lastName, .date], fulfilled: []), Template(image: "SlateWhimsical", needs: [.firstName, .firstName, .lastName, .date], fulfilled: [])]),
                               Product(title: "Stamps", description: "Our self-inking address stamps last for thousands of impressions and are a much-needed gift that your client will use on a regular basis.", price: 34.45, fiveUnitPrice: 26.25, tenUnitPrice: 24, twentyUnitPrice: 22.05, image: "Stamp", category: .Stamps, count: 0),
                               Product(title: "Steak Knife Set", description: "Made in France, these knives were inspired by pocket knives used by French Shepherds 200 years ago. Each blade is made from high quality stainless steel, light weight acrylic handle (Ivory) with a beautiful Platine detailing down the spine.", price: 125, fiveUnitPrice: 120.25, tenUnitPrice: 114.95, twentyUnitPrice: 108.45, image: "Steak Knife Set", category: .KnifeSet, count: 0),
                               Product(title: "3 Tool Cheese Board", description: "The bamboo is topped by a tempered Pyrex cutting board that is conveniently removable, so it can double as a serving tray. There is no need to go back to the kitchen for a cheese knife. Simply pull out the 'hidden' drawer and you'll find 3 varieties of cheese tools ready to use.", price: 88, fiveUnitPrice: 82.98, tenUnitPrice: 78.95, twentyUnitPrice: 76.88, image: "Three Tool", category: .CheeseBoard, count: 0)]
}
