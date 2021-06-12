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
    
    //MARK: - Properties
    
    var products: [Product]?
    
    //MARK: - Methods
    
    func loadProducts() {
        if let file = Bundle.main.url(forResource: "Products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: data)
                self.products = products
            } catch {
                print(error)
            }
        }
    }
}
