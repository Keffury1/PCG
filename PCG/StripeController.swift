//
//  StripeController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import Stripe

class StripeController {
    
    static var shared = StripeController()
    
    var paymentIntentClientSecret: String?
    
    func startCheckout(with amount: Int) {
        let url = URL(string: "")!
        let amountCents = amount * 100
        let json: [String: Any] = [
            "amount": amountCents,
            "currency": "usd"
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let clientSecret = json["clientSecret"] as? String else { return }
            
            if let error = error {
                print("Error creating payment intent: \(error)")
                return
            }
            print("Created PaymentIntent")
            self?.paymentIntentClientSecret = clientSecret
        })
        task.resume()
    }
}

