//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 6/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK: - Properties
    
    var subTotal = 0.00
    
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
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubSubviews()
        updateViews()
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
    
    internal func updateViews() {
        subTotal = 0.00
        
        for item in cart {
            let price = Double(round((1000*Double(item.price))/1000)) * Double(item.count)
            subTotal += price
        }
        
        subtotalLabel.text = "$\(subTotal)"
        taxLabel.text = "$\(1.95)"
        shippingLabel.text = "$\(5.98)"
        
        subTotal += 1.95
        subTotal += 5.98
        
        totalLabel.text = "$\(Double(round((1000*subTotal)/1000)))"
        cartTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func viewProductsButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func creditCardButtonTapped(_ sender: Any) {
    }
    
    @IBAction func applePayButtonTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
        
        cell.productImageView.image = UIImage(named: (item.chosenTemplate?.first!.name)!)
        cell.productImageView.layer.cornerRadius = 10
        cell.titleLabel.text = item.name.capitalized
        cell.detailLabel.text = "Category: \(item.category)"
        cell.priceLabel.text = "$\(item.price * item.count)"
        cell.countLabel.text = "x\(item.count)"
        cell.index = indexPath.row
        
        cell.updateDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateViews()
        }
    }
}

extension CartViewController: UpdateDelegate {
    func updateNeeded(increase: Bool, index: Int) {
        if increase {
            var product = cart[index]
            product.count += 1
            cart[index] = product
        } else {
            var product = cart[index]
            if product.count == 1 {
                return
            } else {
                product.count -= 1
                cart[index] = product
            }
        }
        updateViews()
    }
}
