//
//  CreditCardViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/14/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import Stripe

class CreditCardViewController: UIViewController {

    // MARK: - Properties
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    var paramsDelegate: CardParamsDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardIOView: CardIOView!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCardView()
    }
    
    // MARK: - Methods
    
    private func setupCardView() {
        cardView.addSubview(cardTextField)
        cardTextField.translatesAutoresizingMaskIntoConstraints = false
        cardTextField.textColor = .white
        cardTextField.backgroundColor = UIColor(named: "Navy")!
        NSLayoutConstraint.activate([
            cardTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20.0),
            cardTextField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
            cardTextField.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30.0),
            cardTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        cardIOView.layer.cornerRadius = 10
        cardIOView.clipsToBounds = true
        cardIOView.layer.masksToBounds = true
        cardIOView.guideColor = .white
        cardIOView.delegate = self
        confirmButton.layer.cornerRadius = 10
    }
    // MARK: - Actions
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let cardParams = cardTextField.cardParams
        paramsDelegate?.cardEntered(params: cardParams)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}

extension CreditCardViewController: CardIOViewDelegate {
    func cardIOView(_ cardIOView: CardIOView!, didScanCard cardInfo: CardIOCreditCardInfo!) {
        let params = STPCardParams()
        let cardParams = STPPaymentMethodCardParams(cardSourceParams: params)
        cardParams.number = cardInfo.cardNumber
        let month = Int(bitPattern: cardInfo.expiryMonth)
        let year = Int(bitPattern: cardInfo.expiryYear)
        cardParams.expMonth = NSNumber(integerLiteral: month)
        cardParams.expYear = NSNumber(integerLiteral: year)
        cardTextField.cardParams = cardParams
        cardTextField.reloadInputViews()
    }
}
