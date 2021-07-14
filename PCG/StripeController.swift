//
//  StripeController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import PassKit
import Stripe

class StripeController {
    
    enum APIError: Error {
        case unknown

        var localizedDescription: String {
            switch self {
            case .unknown:
                return "Unknown error"
            }
        }
    }
    
    static var shared = StripeController()
    
    var paymentIntentClientSecret: String?
    
    var backendBaseURL: URL = URL(string: "https://perfectclosinggift.herokuapp.com/")!
    
    var appleMerchantID: String = "merchant.com.BobbyKeffury.PCG"
    
    var paymentSheet: PaymentSheet?
    
    let companyName = "Perfect Closing Gift"
    let paymentCurrency: String = "usd"
    
//    // MARK: Create a PaymentSheet instance
//    var configuration = PaymentSheet.Configuration()
//    configuration.merchantDisplayName = "Perfect Closing Gift"
//    configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//    self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
    
    func createPaymentIntent(
        products: [CDProduct], shippingMethod: PKShippingMethod?, country: String? = nil,
        completion: @escaping ((Result<String, Error>) -> Void)
    ) {
        let url = self.backendBaseURL.appendingPathComponent("create_payment_intent")
        var params: [String: Any] = [
            "metadata": [
                // example-mobile-backend allows passing metadata through to Stripe
                "payment_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB"
            ]
        ]
        params["products"] = products.map({ (p) -> String in
            return p.name!
        })
        if let shippingMethod = shippingMethod {
            params["shipping"] = shippingMethod.identifier
        }
        params["country"] = country
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data,
                    let json =
                        ((try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any]) as [String: Any]??),
                    let secret = json?["secret"] as? String
                else {
                    completion(.failure(error ?? APIError.unknown))
                    return
                }
                completion(.success(secret))
            })
        task.resume()
    }
}

