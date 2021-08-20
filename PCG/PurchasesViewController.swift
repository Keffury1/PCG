//
//  PurchasesViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 2/15/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import CoreData

class PurchasesViewController: UIViewController {

    // MARK: - Properties
    
    lazy var fetchedHistoryController: NSFetchedResultsController<History> = {
        let fetchRequest: NSFetchRequest<History> = History.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
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
}

extension PurchasesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedHistoryController.fetchedObjects?.first?.historyArray.count == 0 {
            emptyTableView.alpha = 1
            emptyTableView.isUserInteractionEnabled = true
            purchasesTableView.alpha = 0
            purchasesTableView.isUserInteractionEnabled = false
        } else if fetchedHistoryController.fetchedObjects?.first?.historyArray.count == nil {
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
        return fetchedHistoryController.fetchedObjects?.first?.historyArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as? PurchaseTableViewCell else { return UITableViewCell() }
        
        guard let history = fetchedHistoryController.fetchedObjects?.first?.historyArray else { return UITableViewCell() }
        
        let item = history[indexPath.row]
        
        cell.purchaseImageView.image = UIImage(named: "\(item.image!)")
        cell.purchaseImageView.layer.cornerRadius = 10
        cell.purchaseTitleLabel.text = item.name!
        cell.addressLabel.text = item.address!
        cell.dateLabel.text = item.date!
        cell.purchaseImageView.contentMode = .scaleAspectFill
        
        return cell
    }
}
