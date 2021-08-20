//
//  ReviewViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import CoreData
import ProgressHUD

class ReviewViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    var reviewing: Bool = true
    var cartProduct: CDProduct? {
        didSet {
            reviewing = false
        }
    }
    var template: Template?
    var image: UIImage?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Cart> = {
        
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: false)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var fulfilledTableView: UITableView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if product?.id == 4 {
            imageView.contentMode = .scaleAspectFill
        } else if product?.id == 20 {
            imageView.contentMode = .scaleAspectFill
        }
        
        if image != nil {
            imageView.image = image
        } else {
            guard let template = template else { imageView.image = UIImage(named: "\(cartProduct?.chosenArray.first?.name ?? "")"); return }
            imageView.image = UIImage(named: "\(template.name)")
        }
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        fulfilledTableView.delegate = self
        fulfilledTableView.dataSource = self
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.addShadow()
        if reviewing {
            addToCartButton.setTitle(" Add to Cart", for: .normal)
        } else {
            addToCartButton.setTitle(" Return", for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        if reviewing {
            guard let template = template, var product = product else { return }
            ProgressHUD.show()
            product.chosenTemplate?.append(template)
            product.count += 1
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
            let moc = CoreDataStack.shared.mainContext
            let newProduct = CDProduct(category: product.category, count: Int16(product.count), descriptionText: product.description, discountPrice: Int16(product.discountPrice), id: Int16(product.id), image: product.image, name: product.name, price: Int16(product.price),address: "", date: "", context: moc)
            let newTemplate = CDTemplate(id: Int16(template.id), name: template.name, context: moc)
            for fulfilled in template.fulfilled {
                newTemplate.addToFulfilled(Fulfilled(text: fulfilled.value, context: moc))
            }
            newProduct.addToChosenTemplate(newTemplate)
            
            if fetchedResultsController.fetchedObjects?.isEmpty == true {
                let cart = Cart(name: "New Cart", notes: "", context: moc)
                cart.addToCartProducts(newProduct)
            } else {
                fetchedResultsController.fetchedObjects?.first?.addToCartProducts(newProduct)
            }
            
            do {
                try moc.save()
                ProgressHUD.showSuccess()
            } catch {
                print("Error saving added product: \(error)")
            }
            navigationController?.popToRootViewController(animated: true)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if reviewing {
            navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewing {
            return template?.fulfilled.count ?? 0
        } else {
            let template = cartProduct?.chosenArray.first
            return template?.fulfilled?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fulfilledCell", for: indexPath) as? FulfilledTableViewCell else { return UITableViewCell() }
        
        if reviewing {
            let sortedKeys = Array((template?.fulfilled.keys)!).sorted(by: <)
            let int = sortedKeys[indexPath.row]
            cell.titleLabel.text = template?.fulfilled[int]
            return cell
        } else {
            let template = cartProduct?.chosenArray.first
            let fulfilled = template?.fulfilledArray[indexPath.row]
            cell.titleLabel.text = fulfilled?.text
            return cell
        }
    }
}
