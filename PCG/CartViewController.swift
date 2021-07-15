//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 6/3/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import CoreData
import ProgressHUD

class CartViewController: UIViewController {
    
    //MARK: - Properties
    
    var subTotal = 0.00
    
    lazy var fetchedResultsController: NSFetchedResultsController<Cart> = {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
    var cart: [CDProduct]?
    
    // MARK: - Outlets
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var viewProductsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setubSubviews()
        cart = fetchedResultsController.fetchedObjects?.first?.cartArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartTableView.reloadData()
        calcPrice()
    }
    
    // MARK: - Methods
    
    private func setubSubviews() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        checkoutButton.layer.cornerRadius = 10
        checkoutButton.addShadow()
        viewProductsButton.layer.cornerRadius = 10
        emptyCartView.layer.cornerRadius = 10.0
        emptyCartView.addShadow()
        emptyCartView.layer.borderColor = UIColor(named: "Tan")!.cgColor
        emptyCartView.layer.borderWidth = 0.5
    }
    
    private func calcPrice() {
        guard let cart = cart else { return }
        subTotal = 0.0
        for item in cart {
            let price = Double(round((1000*Double(item.price))/1000)) * Double(item.count)
            subTotal += price
        }
    }
    
    // MARK: - Actions
    
    @IBAction func viewProductsButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        calcPrice()
        self.performSegue(withIdentifier: "checkoutSegue", sender: self)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkoutSegue" {
            if let detailVC = segue.destination as? CheckoutViewController {
                detailVC.amount = subTotal
                detailVC.parentVC = self
            }
        }
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedResultsController.fetchedObjects?.isEmpty == true {
            cartTableView.alpha = 0
            cartTableView.isUserInteractionEnabled = false
            emptyCartView.alpha = 1
            emptyCartView.isUserInteractionEnabled = true
            checkoutButton.setTitle("", for: .normal)
            checkoutButton.setImage(nil, for: .normal)
            checkoutButton.isUserInteractionEnabled = false
        } else if fetchedResultsController.fetchedObjects?.first?.cartArray.count == 0 {
            cartTableView.alpha = 0
            cartTableView.isUserInteractionEnabled = false
            emptyCartView.alpha = 1
            emptyCartView.isUserInteractionEnabled = true
            checkoutButton.setTitle("", for: .normal)
            checkoutButton.setImage(nil, for: .normal)
            checkoutButton.isUserInteractionEnabled = false
        } else {
            cartTableView.alpha = 1
            cartTableView.isUserInteractionEnabled = true
            emptyCartView.alpha = 0
            emptyCartView.isUserInteractionEnabled = false
            checkoutButton.setTitle(" Checkout", for: .normal)
            checkoutButton.setImage(UIImage(systemName: "cart.circle"), for: .normal)
            checkoutButton.isUserInteractionEnabled = true
        }
        return fetchedResultsController.fetchedObjects?.first?.cartArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartItemCell", for: indexPath) as? CartItemTableViewCell else { return UITableViewCell() }
        
        guard let cart = fetchedResultsController.fetchedObjects?.first?.cartArray else { return UITableViewCell() }
        let item = cart[indexPath.row]
        
        let chosen = item.chosenArray.first
        cell.productImageView.image = UIImage(named: chosen!.name!)
        cell.productImageView.layer.cornerRadius = 10
        cell.titleLabel.text = item.name?.capitalized
        cell.detailLabel.text = "Category: \(item.category ?? "")"
        cell.priceLabel.text = "$\(item.price * item.count)"
        cell.countLabel.text = "x\(item.count)"
        cell.index = indexPath.row
        
        if item.id == 1 {
            cell.productImageView.contentMode = .scaleAspectFill
        } else if item.id == 2 {
            cell.productImageView.contentMode = .scaleAspectFill
        } else if item.id == 4 {
            cell.productImageView.contentMode = .scaleAspectFill
        } else {
            cell.productImageView.contentMode = .scaleAspectFit
        }
        
        cell.updateDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let NSCart = fetchedResultsController.fetchedObjects?.first
            let cart = fetchedResultsController.fetchedObjects?.first?.cartArray
            let product = cart![indexPath.row]
            DispatchQueue.main.async {
                let moc = CoreDataStack.shared.mainContext
                NSCart?.removeFromCartProducts(product)
                moc.delete(product)
                do {
                    try moc.save()
                    tableView.reloadData()
                } catch {
                    moc.reset()
                    print("Error saving managed object context: \(error)")
                }
            }
        }
    }
}

extension CartViewController: UpdateDelegate {
    func updateNeeded(increase: Bool, index: Int) {
        guard var cart = fetchedResultsController.fetchedObjects?.first?.cartArray else { return }
        if increase {
            let product = cart[index]
            product.count += 1
            cart[index] = product
        } else {
            let product = cart[index]
            if product.count == 1 {
                return
            } else {
                product.count -= 1
                cart[index] = product
            }
        }
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            print("Error saving added product: \(error)")
        }
        cartTableView.reloadData()
    }
}
