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
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var purchasesTableView: UITableView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        purchasesTableView.dataSource = self
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
    }
    
    // MARK: - Actions
    
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as? PurchaseTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
