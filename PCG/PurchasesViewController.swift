//
//  PurchasesViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 2/15/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class PurchasesViewController: UIViewController {

    // MARK: - Properties
    
    var products: [String] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var purchasesTableView: UITableView!
    @IBOutlet weak var emptyTableView: UIView!
    @IBOutlet weak var viewProductsButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        purchasesTableView.dataSource = self
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        viewProductsButton.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func viewProductsButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPurchaseSegue" {
            if let detailVC = segue.destination as? PurchaseDetailViewController {
                // FIX ME
                detailVC.purchase = nil
            }
        }
    }

}

extension PurchasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            emptyTableView.alpha = 1
            emptyTableView.isUserInteractionEnabled = true
            purchasesTableView.alpha = 0
            purchasesTableView.isUserInteractionEnabled = false
        } else {
            emptyTableView.alpha = 0
            emptyTableView.isUserInteractionEnabled = false
            purchasesTableView.alpha = 1
            purchasesTableView.isUserInteractionEnabled = true
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as? PurchaseTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
