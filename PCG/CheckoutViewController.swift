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
import CoreData
import NBBottomSheet

protocol CardParamsDelegate {
    func cardEntered(params: STPPaymentMethodCardParams)
}

class CheckoutViewController: UIViewController {

    // MARK: - Properties
    
    var amount: Double?
    var total: Double?
    var shipping: Double?
    var tax: Double?
    var address: String?
    var cardParams: STPPaymentMethodCardParams?
    var configuration: Any?
    var dismissDelegate: DismissDelegate?
    var one: [String] = ["WA","OR","NV","AZ","UT","ID","MT","WY","CO","NM","TX"]
    var two: [String] = ["NC","GA","FL","VA","WV","TN","AL","KY","MD","PA","NY","AL","SC"]
    var three: [String] = ["CT","MA","NH","VT","ME","OH","MY","IN"]
    
    lazy var fetchedResultsController: NSFetchedResultsController<Cart> = {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
    lazy var fetchedHistoryController: NSFetchedResultsController<History> = {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var shippingButton: UIButton!
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shipping = PKShippingMethod()
        shipping.identifier = "shipping"
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
        notesTextView.text = "Any Notes?"
        notesTextView.textColor = UIColor(named: "Tan")!
        notesTextView.delegate = self
        notesTextView.layer.borderColor = UIColor(named: "Tan")!.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 10
    }
    
    private func updateViews() {
        subtotalLabel.text = "$\(amount?.rounded() ?? 0.0)"
        if amount == 0 {
            taxLabel.text = "$0.0"
            shippingLabel.text = "$0.0"
            totalLabel.text = "$0.0"
        } else {
            total = amount
            let tax = 0.0775 * total!
            taxLabel.text = "$\(tax.rounded())"
            shippingLabel.text = "$\(shipping ?? 0.0)"
            total! += tax
            total! += shipping ?? 0.0
            totalLabel.text = "$\(Double(round((1000*total!)/1000)))"
            StripeController.shared.startCheckout(with: Int(total!))
        }
    }
    
    private func saveOrder() {
        let cart = fetchedResultsController.fetchedObjects?.first
        let order = cart!.cartArray
        let moc = CoreDataStack.shared.mainContext
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: Date())
        
        for product in order {
            product.address = address
            if date == "" {
                return
            } else {
                product.date = date
            }
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving date & address to order: \(error)")
        }
        
        if let history = fetchedHistoryController.fetchedObjects?.first {
            history.addToHistoryProducts(NSSet(array: order))
        } else {
            let history = History(name: "New History", context: moc)
            history.addToHistoryProducts(NSSet(array: order))
        }
        
        moc.delete(cart!)
        
        do {
            try moc.save()
            dismissDelegate?.dismiss()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Error saving order history: \(error)")
        }
    }
    
    private func cardPayment(params: STPPaymentMethodCardParams) {
        guard let paymentIntentClientSecret = StripeController.shared.paymentIntentClientSecret else { return }
        // Collect card details
        let paymentMethodParams = STPPaymentMethodParams(card: params, billingDetails: nil, metadata: nil)
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams

        // Submit the payment
        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(paymentIntentParams,
                                      with: self) { (status, _, _) in
            switch status {
            case .failed:
                ProgressHUD.showError()
                print("Payment Failed")
            case .canceled:
                ProgressHUD.dismiss()
                print("Payment Canceled")
            case .succeeded:
                ProgressHUD.showSuccess()
                self.saveOrder()
                print("Payment Successful")
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func setShippingCost(state: String) {
        let cart = fetchedResultsController.fetchedObjects?.first
        let order = cart!.cartArray
        
        for product in order {
            switch product.id {
            case 1, 7, 16, 17:
                shipping = 5.65
            case 2:
                shipping = 11.97
            case 20, 6, 15:
                shipping = 9.95
            case 4, 8, 10, 11, 12, 14, 18, 21:
                checkState(state: state, id: 1)
            case 9, 19:
                checkState(state: state, id: 1)
            case 3:
                checkState(state: state, id: 2)
            case 13:
                checkState(state: state, id: 1)
            default:
                return
            }
        }
    }
    
    private func checkState(state: String, id: Int) {
        switch id {
        case 1:
            if one.contains(state) {
                shipping = 14.95
            } else if state == "CA" {
                shipping = 12.95
            } else {
                shipping = 16.95
            }
        case 2:
            if two.contains(state) {
                shipping = 15.95
            } else if three.contains(state) {
                shipping = 16.95
            } else {
                shipping = 18.95
            }
        default:
            return
        }
    }
    
    // MARK: - Actions
    
    @IBAction func shippingButtonTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDidFinishEditing(_ sender: SkyFloatingLabelTextField) {
        if let text = sender.text {
            if text == "" {
                self.address = nil
                self.mapView.removeAnnotations(mapView.annotations)
            } else {
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
                    if placemarks.count > 0 {
                        let pm = placemarks[0]
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
                        if pm.administrativeArea != nil {
                            self.setShippingCost(state: pm.administrativeArea!)
                        }
                        self.address = addressString
                        self.updateViews()
                    }
                }
            }
        }
    }
    
    @IBAction func creditCardButtonTapped(_ sender: Any) {
        guard address != nil else {
            ProgressHUD.showError("Enter Shipping Address", image: nil, interaction: true)
            return
        }
        self.configuration = NBBottomSheetConfiguration(animationDuration: 0.4,
                                                        sheetSize: .fixed(300))
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreditCardVC") as! CreditCardViewController
        vc.paramsDelegate = self
        vc.view.layer.cornerRadius = 30
        let bottomSheetController = NBBottomSheetController(configuration: configuration as? NBBottomSheetConfiguration)
        bottomSheetController.present(vc, on: self)
    }
    
    @IBAction func applePayButtonTapped(_ sender: Any) {
        guard address != nil else {
            ProgressHUD.showError("Enter Shipping Address", image: nil, interaction: true)
            return
        }
        let merchantIdentifier = "merchant.com.RobertKeffury.PCG"
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")

        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "PCG", amount: NSDecimalNumber(value: amount!)),
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
            if textField.text == nil {
                self.address = nil
                self.mapView.removeAnnotations(mapView.annotations)
            } else {
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
                    if placemarks.count > 0 {
                        let pm = placemarks[0]
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }
                        if pm.administrativeArea != nil {
                            self.setShippingCost(state: pm.administrativeArea!)
                        }
                        self.address = addressString
                        self.updateViews()
                    }
                }
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
            saveOrder()
            break
        case .error:
            break
        case .userCancellation:
            break
        @unknown default:
            fatalError()
        }
    }
}

extension CheckoutViewController: CardParamsDelegate {
    func cardEntered(params: STPPaymentMethodCardParams) {
        cardPayment(params: params)
    }
}

extension CheckoutViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(named: "Tan")! {
            textView.text = nil
            textView.textColor = UIColor(named: "Navy")!
            textView.layer.borderColor = UIColor(named: "Navy")!.cgColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Any Notes?"
            textView.textColor = UIColor(named: "Tan")!
            notesTextView.layer.borderColor = UIColor(named: "Tan")!.cgColor
        } else {
            let moc = CoreDataStack.shared.mainContext
            if let cart = fetchedResultsController.fetchedObjects?.first {
                cart.notes = textView.text
                do {
                    try moc.save()
                } catch {
                    print("Error saving notes to cart: \(error)")
                }
            }
        }
    }
}
