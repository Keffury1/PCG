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
    
    var products: [Product] = []
    var key: Int = 1
    var count: Int = 1
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
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
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as? CartItemTableViewCell else { return UITableViewCell() }
        
        let product = products[indexPath.row]
        cell.keyLabel.text = "\(key)."
        key += 1
        cell.valueLabel.text = product.title
        cell.countLabel.text = "x\(count)"
        count += 1
        cell.priceLabel.text = "$\(product.price)"
        
        return cell
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        applePayButton.layer.cornerRadius = 10.0
        enterCardDetailsButton.layer.cornerRadius = 10.0
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
    }
    
    private func updateTotal() {
        totalLabel.font = UIFont(name: "BebasNeue-Regular", size: 50)
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
