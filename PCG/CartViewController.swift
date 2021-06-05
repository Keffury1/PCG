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
    
    var cart: [Product] = []
    
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
    @IBOutlet weak var viewProductsButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubSubviews()
    }
    
    // MARK: - Methods
    
    private func setubSubviews() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        creditCardButton.layer.cornerRadius = 10
        creditCardButton.addShadow()
        applePayButton.layer.cornerRadius = 10
        applePayButton.addShadow()
        viewProductsButton.layer.cornerRadius = 10
        emptyCartView.layer.cornerRadius = 10.0
        emptyCartView.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func viewProductsButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func creditCardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func applePayButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cart.isEmpty == true {
            cartTableView.alpha = 0
            cartTableView.isUserInteractionEnabled = false
            emptyCartView.alpha = 1
            emptyCartView.isUserInteractionEnabled = true
        } else {
            cartTableView.alpha = 1
            cartTableView.isUserInteractionEnabled = true
            emptyCartView.alpha = 0
            emptyCartView.isUserInteractionEnabled = false
        }
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartItemCell", for: indexPath) as? CartItemTableViewCell else { return UITableViewCell() }
        
        let item = cart[indexPath.row]
        
        cell.productImageView.image = UIImage(named: item.image)
        cell.titleLabel.text = item.title.capitalized
        cell.detailLabel.text = item.description
        cell.priceLabel.text = "$\(item.price)"
        cell.countLabel.text = "\(item.count)"
        
        return cell
    }
}
