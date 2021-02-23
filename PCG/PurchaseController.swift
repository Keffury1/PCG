//
//  PurchaseController.swift
//  PCG
//
//  Created by Bobby Keffury on 2/22/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation

class PurchaseController {
    static let shared = PurchaseController()
    let baseUrl = URL(string: "https://perfect-closing-gift-default-rtdb.firebaseio.com/")!
    
    func getPurchases(completion: @escaping ([Product]) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let purchases = try decoder.decode([Product].self, from: data)
                completion(purchases)
            } catch {
                print(error)
                return
            }
        }.resume()
    }
    
    func addPurchase(){
        
    }
}
