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
        cardTextField.textColor = UIColor(named: "Navy")!
        cardTextField.backgroundColor = .white
        NSLayoutConstraint.activate([
            cardTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20.0),
            cardTextField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
            cardTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20.0),
            cardTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ])
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
