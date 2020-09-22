//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 9/21/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK: - Properties
    
    var cart: [Product] = []
    var key: Int = 1
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var enterCardDetailsButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        setupSubviews()
        updateTotal()
        cartTableView.reloadData()
        updateTotal()
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? CartItemTableViewCell else { return UITableViewCell() }
        
        let product = cart[indexPath.row]
        cell.keyLabel.text = "\(key)."
        key += 1
        cell.valueLabel.text = product.title
        cell.countLabel.text = "x\(product.count)"
        cell.priceLabel.text = "$\(product.price)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            cart.remove(at: indexPath.row)
            tableView.reloadData()
            updateTotal()
        }
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        applePayButton.layer.cornerRadius = 15.0
        applePayButton.addShadow()
        enterCardDetailsButton.layer.cornerRadius = 15.0
        enterCardDetailsButton.addShadow()
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
    }
    
    private func updateTotal() {
        var count: Double = 0.00
        var items: Int = 0
        for product in self.cart {
            items += 1
            count += product.price
        }
        
        let doubleString = String(format: "%.2f", count)
        if items == 1 {
            itemsLabel.text = " \(items) item"
        } else {
            itemsLabel.text = " \(items) items"
        }
        totalLabel.text = "$\(doubleString)"
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
