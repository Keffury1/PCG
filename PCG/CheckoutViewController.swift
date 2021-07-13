//
//  CheckoutViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import Stripe
import PassKit
import MapKit
import SkyFloatingLabelTextField
import ProgressHUD

class CheckoutViewController: UIViewController {

    // MARK: - Properties
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    var amount: Double?
    var shipping: Double?
    var tax: Double?
    
    // MARK: - Outlets
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var shippingButton: UIButton!
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var creditCardButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StripeController.shared.startCheckout(with: self.amount!)
        setupSubviews()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        mapView.layer.cornerRadius = 10
        applePayButton.layer.cornerRadius = 10
        applePayButton.addShadow()
        creditCardButton.layer.cornerRadius = 10
        creditCardButton.addShadow()
        textField.delegate = self
    }
    
    private func makePayment() {
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
                ProgressHUD.showError()
            case .canceled:
                ProgressHUD.showError()
            case .succeeded:
                ProgressHUD.showSuccess()
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func updateViews() {
        if var amount = amount {
            subtotalLabel.text = "$\(amount)"
            if amount == 0 {
                taxLabel.text = "$0.0"
                shippingLabel.text = "$0.0"
            } else {
                taxLabel.text = "$\(1.95)"
                shippingLabel.text = "$\(5.98)"
                amount += 1.95
                amount += 5.98
            }
            
            totalLabel.text = "$\(Double(round((1000*amount)/1000)))"
        }
    }
    
    // MARK: - Actions
    
    @IBAction func shippingButtonTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDidFinishEditing(_ sender: SkyFloatingLabelTextField) {
        if let text = sender.text {
            let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(text) { (placemarks, error) in
                    guard let placemarks = placemarks, let location = placemarks.first?.location else {
                        print("Error Getting Location: \(error!)")
                        return
                    }
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    self.mapView.centerCoordinate = annotation.coordinate
                    let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 30000)!, longitudinalMeters: CLLocationDistance(exactly: 30000)!)
                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
            }
        }
    }
    
    @IBAction func creditCardButtonTapped(_ sender: Any) {
        makePayment()
    }
    
    @IBAction func applePayButtonTapped(_ sender: Any) {
        let merchantIdentifier = "merchant.com.BobbyKeffury.PCG"
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")
        
        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "Perfect Closing Gift", amount: NSDecimalNumber(value: amount!)),
        ]
        // Initialize an STPApplePayContext instance
        if let applePayContext = STPApplePayContext(paymentRequest: paymentRequest, delegate: self) {
            // Present Apple Pay payment sheet
            applePayContext.presentApplePay()
        } else {
            // There is a problem with your Apple Pay configuration
            ProgressHUD.showError()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension CheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}

extension CheckoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            let geoCoder = CLGeocoder()
            mapView.removeAnnotations(mapView.annotations)
            geoCoder.geocodeAddressString(text) { (placemarks, error) in
                guard let placemarks = placemarks, let location = placemarks.first?.location else {
                    print("Error Getting Location: \(error!)")
                    return
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                self.mapView.addAnnotation(annotation)
                self.mapView.centerCoordinate = annotation.coordinate
                let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 20000)!, longitudinalMeters: CLLocationDistance(exactly: 20000)!)
                self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                textField.resignFirstResponder()
            }
        }
        return true
    }
}

extension CheckoutViewController: STPApplePayContextDelegate {
    func applePayContext(_ context: STPApplePayContext, didCreatePaymentMethod paymentMethod: STPPaymentMethod, paymentInformation: PKPayment, completion: @escaping STPIntentClientSecretCompletionBlock) {
        guard let paymentIntentClientSecret = StripeController.shared.paymentIntentClientSecret else { return }
        let clientSecret = paymentIntentClientSecret
        completion(clientSecret, nil);
    }
    
    func applePayContext(_ context: STPApplePayContext, didCompleteWith status: STPPaymentStatus, error: Error?) {
        switch status {
        case .success:
            ProgressHUD.showSuccess()
            break
        case .error:
            ProgressHUD.showError()
            break
        case .userCancellation:
            break
        @unknown default:
            fatalError()
        }
    }
}
