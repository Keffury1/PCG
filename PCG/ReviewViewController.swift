//
//  ReviewViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import CoreData

class ReviewViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    var template: Template?
    
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
        guard let template = template else { return }
        imageView.image = UIImage(named: "\(template.name)")
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        
        fulfilledTableView.delegate = self
        fulfilledTableView.dataSource = self
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let template = template, var product = product else { return }
        product.chosenTemplate?.append(template)
        product.count += 1
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        let moc = CoreDataStack.shared.mainContext
        let newProduct = CDProduct(category: product.category, count: Int16(product.count), descriptionText: product.description, discountPrice: Int16(product.discountPrice), id: Int16(product.id), image: product.image, name: product.name, price: Int16(product.price), context: moc)
        let newTemplate = CDTemplate(id: Int16(template.id), name: template.name, context: moc)
        newProduct.addToChosenTemplate(newTemplate)
        
        if fetchedResultsController.fetchedObjects?.isEmpty == true {
            let cart = Cart(name: "New Cart", context: moc)
            cart.addToCartProducts(newProduct)
        } else {
            fetchedResultsController.fetchedObjects?.first?.addToCartProducts(newProduct)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving added product: \(error)")
        }
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return template?.fulfilled.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fulfilledCell", for: indexPath) as? FulfilledTableViewCell else { return UITableViewCell() }
        
        let sortedKeys = Array((template?.fulfilled.keys)!).sorted(by: <)
        
        let int = sortedKeys[indexPath.row]
        
        cell.titleLabel.text = template?.fulfilled[int]
        
        return cell
    }
}
