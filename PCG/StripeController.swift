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
    
    var backendBaseURL: String = "https://perfectclosinggift.herokuapp.com/"
    
    var appleMerchantID: String = "merchant.com.BobbyKeffury.PCG"
    
    var paymentSheet: PaymentSheet?
    
    let companyName = "Perfect Closing Gift"
    let paymentCurrency: String = "usd"
    
    func startCheckout(with amount: Double) {
        let url = URL(string: backendBaseURL)!
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
                  let clientSecret = json["clientSecret"] as? String,
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let self = self else { return }
            
            if let error = error {
                print("Error creating payment intent: \(error)")
                return
            }
            print("Created PaymentIntent")
            self.paymentIntentClientSecret = clientSecret
            
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Perfect Closing Gift"
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
        })
        task.resume()
    }
}

