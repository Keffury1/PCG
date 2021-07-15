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
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardIOView: CardIOView!
    
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
    }
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
