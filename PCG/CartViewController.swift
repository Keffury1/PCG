//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 6/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    
    @IBAction func creditCardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func applePayButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
