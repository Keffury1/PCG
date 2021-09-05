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
    var addOns: [String]? = ["Thank You Card", "Gift Box", "Dog Treats"]
    var addOn: String?
    
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
    @IBOutlet weak var moveToBackButton: UIButton!
    @IBOutlet weak var moveToBackLabel: UILabel!
    @IBOutlet weak var addOnCollectionView: UICollectionView!
    
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
        
        if product?.id == 10 {
            moveToBackOn()
        } else if product?.id == 14 {
            moveToBackOn()
        } else {
            moveToBackOff()
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
        addOnCollectionView.delegate = self
        addOnCollectionView.dataSource = self
        
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.addShadow()
        if reviewing {
            addToCartButton.setTitle(" Add to Cart", for: .normal)
            addOnCollectionView.isUserInteractionEnabled = true
            moveToBackButton.isUserInteractionEnabled = false
        } else {
            addToCartButton.setTitle(" Return", for: .normal)
            addOnCollectionView.isUserInteractionEnabled = false
            moveToBackButton.isUserInteractionEnabled = true
        }
        
        if template == nil {
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
        }
    }
    
    private func moveToBackOn() {
        moveToBackLabel.isHidden = false
        moveToBackButton.isHidden = false
        moveToBackButton.isUserInteractionEnabled = true
    }
    
    private func moveToBackOff() {
        moveToBackLabel.isHidden = true
        moveToBackButton.isHidden = true
        moveToBackButton.isUserInteractionEnabled = false
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        if reviewing {
            guard var product = product else { return }
            ProgressHUD.show()
            product.count += 1
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
            let moc = CoreDataStack.shared.mainContext
            let newProduct = CDProduct(category: product.category, count: Int16(product.count), descriptionText: product.description, discountPrice: Int16(product.discountPrice), id: Int16(product.id), image: product.image, name: product.name, price: Int16(product.price),address: "", date: "", addOn: product.addOn ?? "", back: product.back ?? "", context: moc)
            
            if let template = template {
                product.chosenTemplate?.append(template)
                let newTemplate = CDTemplate(id: Int16(template.id), name: template.name, context: moc)
                for fulfilled in template.fulfilled {
                    newTemplate.addToFulfilled(Fulfilled(text: fulfilled.value, context: moc))
                }
                newProduct.addToChosenTemplate(newTemplate)
            } else {
                self.imageView.image = image
                let data = image?.pngData()
                let newTemplate = CDTemplate(id: 0, name: "image", context: moc)
                let fulfilled = Fulfilled(text: "\(data ?? Data())", context: moc)
                newTemplate.addToFulfilled(fulfilled)
                newProduct.addToChosenTemplate(newTemplate)
            }
            
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
    
    @IBAction func moveToBackTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(systemName: "square") {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            product?.back = "True"
        } else {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            product?.back = "False"
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

extension ReviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addOns?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addOnCell", for: indexPath) as? AddOnCollectionViewCell else { return UICollectionViewCell() }
        
        let addOn = addOns![indexPath.row]
        cell.addOnImageView.image = UIImage(named: addOn)
        cell.addOnTitleLabel.text = addOn.capitalized
        cell.contentView.layer.cornerRadius = 10
        
        if self.addOn == addOn {
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor(named: "Navy")!.cgColor
        } else {
            cell.contentView.layer.borderWidth = 0.5
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.contentView.layer.borderWidth = 1
        cell!.contentView.layer.borderColor = UIColor(named: "Navy")?.cgColor
        let addOn = addOns![indexPath.row]
        product?.addOn = addOn
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell!.contentView.layer.borderWidth = 0.5
        cell!.contentView.layer.borderColor = UIColor.lightGray.cgColor
        product?.addOn = ""
        return
    }
}
