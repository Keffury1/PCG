//
//  CreditCardViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/13/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import Stripe
import ProgressHUD

class CreditCardViewController: UIViewController {

    // MARK: - Properties
    
    var params: STPPaymentMethodCardParams?
    
    // MARK: - Outlets
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    private func makePayment() {
        ProgressHUD.show()
        guard let paymentIntentClientSecret = StripeController.shared.paymentIntentClientSecret, let cardParams = params else { return }
        // Collect card details
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(paymentIntentParams,
                                      with: self) { (status, _, _) in
            switch status {
            case .failed:
                ProgressHUD.showError()
            case .canceled:
                return
            case .succeeded:
                ProgressHUD.showSuccess()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.dismiss(animated: true, completion: nil)
                }
            @unknown default:
                return
            }
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension CreditCardViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
