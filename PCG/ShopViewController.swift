//
//  ShopViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import DropDown
import CoreData

class ShopViewController: UIViewController {

    // MARK: - Properties
    var items: [String : String] = ["Cutting Boards":"CuttingBoard", "Lanterns":"Lantern", "Coaster Sets":"CoasterSet","Cheese Boards":"CheeseBoard", "Stamps":"Stamp", "Knife Sets":"KnifeSet", "Ornaments":"Ornament", "Doormats":"Doormat", "Jars":"DogTreatJar", "View All Products":""]
    var prices: [String: String] = ["4 - White Label":"4","3 - $100 ↓":"3","1 - $25 ↓":"1","2 - $50 ↓":"2"]
    let productController = ProductController()
    var price: Bool = true
    var display: Bool = true
    var products: [Product] = []
    var product: Product?
    var cart: [Product]?
    let dropDown = DropDown()
    let priceDown = DropDown()
    
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

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lowToHighButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var cartButton: SSBadgeButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var menuLabel: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        productController.loadProducts()
        guard let products = productController.products else { return }
        self.products = products
        productsCollectionView.reloadData()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let array = fetchedResultsController.fetchedObjects?.first?.cartArray else { return }
        if array.count > 0 {
            cartButton.addBadgeToButon(badge: "\(array.count)")
        } else {
            cartButton.badge = nil
        }
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        highToLowButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        menuLabel.addShadow()
        menuLabel.layer.cornerRadius = 10
    }
    
    func sortByCategory(category: String) {
        var array: [Product] = []
        for item in productController.products! {
            if item.category == category {
                array.append(item)
            }
        }
        self.products = array
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.productsCollectionView.reloadData()
        })
    }
    
    func sortByPrice(price: Int) {
        var array: [Product] = []
        for item in productController.products! {
            if item.price < price {
                array.append(item)
            }
        }
        self.products = array
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.productsCollectionView.reloadData()
        }
    }
    
    func removeChoices(_ string: String) {
        display = true
        menuLabel.setTitle(string, for: .normal)
    }
    
    func turnOnMenu() {
        dropDown.anchorView = menuLabel
        dropDown.bottomOffset = CGPoint(x: 0, y:((dropDown.anchorView?.plainView.bounds.height)! + 5))
        dropDown.backgroundColor = UIColor(named: "Navy")
        dropDown.textColor = .white
        dropDown.separatorColor = UIColor(named: "Tan")!
        dropDown.dataSource = items.keys.sorted()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "View All Products" {
                self.products = productController.products!
                productsCollectionView.reloadData()
                removeChoices("Menu")
            } else {
                removeChoices(item)
                sortByCategory(category: items[item]!)
            }
            UIView.animate(withDuration: 0.3) {
                self.menuButton.transform = self.menuButton.transform.rotated(by: CGFloat(Double.pi))
            }
        }
        dropDown.cancelAction = {
            UIView.animate(withDuration: 0.3) {
                self.menuButton.transform = self.menuButton.transform.rotated(by: CGFloat(Double.pi))
            }
        }
        dropDown.cornerRadius = 10
        dropDown.show()
        UIView.animate(withDuration: 0.5) {
            self.menuButton.transform = self.menuButton.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    
    // MARK: - Actions
    
    @IBAction func priceButtonTapped(_ sender: Any) {
        
        priceDown.anchorView = priceButton
        priceDown.bottomOffset = CGPoint(x: 0, y:((priceDown.anchorView?.plainView.bounds.height)! + 5))
        priceDown.backgroundColor = UIColor(named: "Navy")
        priceDown.textColor = .white
        priceDown.separatorColor = UIColor(named: "Tan")!
        priceDown.dataSource = prices.keys.sorted()
        priceDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "4 - White Label" {
                if price {
                    price = false
                    priceButton.setBackgroundImage(UIImage(systemName: "dollarsign.circle.fill"), for: .normal)
                } else {
                    price = true
                    priceButton.setBackgroundImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
                }
                productsCollectionView.reloadData()
            } else if item == "1 - $25 ↓" {
                sortByPrice(price: 25)
                menuLabel.setTitle("$25 & Under", for: .normal)
            } else if item == "2 - $50 ↓" {
                sortByPrice(price: 50)
                menuLabel.setTitle("$50 & Under", for: .normal)
            } else if item == "3 - $100 ↓" {
                sortByPrice(price: 100)
                menuLabel.setTitle("$100 & Under", for: .normal)
            }
        }
        priceDown.cornerRadius = 10
        priceDown.show()
    }

    @IBAction func lowToHighTapped(_ sender: Any) {
        let array = self.products.sorted(by: { $0.price < $1.price })
        self.products = array
        lowToHighButton.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        highToLowButton.setImage(UIImage(systemName: "chart.bar"), for: .normal)
        productsCollectionView.reloadData()
    }
    
    @IBAction func highToLowTapped(_ sender: Any) {
        let array = self.products.sorted(by: { $0.price > $1.price })
        self.products = array
        lowToHighButton.setImage(UIImage(systemName: "chart.bar"), for: .normal)
        highToLowButton.setImage(UIImage(systemName: "chart.bar.fill"), for: .normal)
        productsCollectionView.reloadData()
    }
    
    @IBAction func menuLabelTapped(_ sender: Any) {
        if display {
            turnOnMenu()
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if display {
            turnOnMenu()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailSegue" {
            if let detailVC = segue.destination as? ProductDetailViewController {
                detailVC.product = self.product
                detailVC.price = price
            }
        }
    }
}
extension ShopViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let product = products[indexPath.row]
        
        if price {
            cell.priceLabel.text = "$\(product.price)"
            cell.priceLabel.isHidden = false
            cell.titleLabel.text = product.name
        } else {
            cell.priceLabel.text = ""
            cell.priceLabel.isHidden = true
            cell.titleLabel.text = product.name
        }
        
        cell.productImageView.image = UIImage(named: product.image)
        cell.productImageView.layer.cornerRadius = 10
        cell.productImageView.clipsToBounds = true
        cell.productImageView.addShadow()
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        self.product = product
        self.performSegue(withIdentifier: "productDetailSegue", sender: self)
    }
    
}
