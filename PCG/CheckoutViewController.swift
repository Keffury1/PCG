//
//  CheckoutViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController {

    // MARK: - Properties
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    var amount: Int?
    
    // MARK: - Outlets
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StripeController.shared.startCheckout(with: self.amount!)
    }
    
    // MARK: - Methods
    
    private func makePayment(amount: Int) {
        guard let paymentIntentClientSecret = StripeController.shared.paymentIntentClientSecret else { return }
        // Collect card details
        let cardParams = cardTextField.cardParams
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(paymentIntentParams,
                                      with: self) { (status, _, _) in
            switch status {
            case .failed:
                print("Payment Failed")
            case .canceled:
                print("Payment Canceled")
            case .succeeded:
                print("Payment Successful")
            @unknown default:
                fatalError()
            }
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension CheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
