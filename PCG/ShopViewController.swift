//
//  ShopViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import DropDown

class ShopViewController: UIViewController {

    // MARK: - Properties
    var items: [String : String] = ["Cutting Boards":"CuttingBoard", "Lanterns":"Lantern", "Coaster Sets":"CoasterSet","Cheese Boards":"CheeseBoard", "Stamps":"Stamp", "Knife Sets":"KnifeSet", "Ornaments":"Ornament", "Doormats":"Doormat", "Jars":"DogTreatJar"]
    let productController = ProductController()
    var price: Bool = true
    var display: Bool = true
    var products: [Product] = []
    var product: Product?
    var cart: [Product]?
    let dropDown = DropDown()
    
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
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let products = productController.products else { return }
        self.products = products
        productsCollectionView.reloadData()
        menuLabel.setTitle("Menu", for: .normal)
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
    
    func removeChoices(_ string: String) {
        display = true
        menuLabel.setTitle(string, for: .normal)
    }
    
    func turnOnMenu() {
        dropDown.anchorView = menuLabel
        dropDown.bottomOffset = CGPoint(x: 0, y:((dropDown.anchorView?.plainView.bounds.height)! + 5))
        dropDown.backgroundColor = UIColor(named: "Navy")
        dropDown.textColor = .white
        dropDown.dataSource = items.keys.sorted { $0 < $1 }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            removeChoices(item)
            sortByCategory(category: items[item]!)
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
        if price {
            price = false
        } else {
            price = true
        }
        productsCollectionView.reloadData()
    }

    @IBAction func lowToHighTapped(_ sender: Any) {
        let array = self.products.sorted(by: { $0.price < $1.price })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @IBAction func highToLowTapped(_ sender: Any) {
        let array = self.products.sorted(by: { $0.price > $1.price })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @IBAction func menuLabelTapped(_ sender: Any) {
        if display {
            turnOnMenu()
        } else {
            dropDown.hide()
            self.products = productController.products!
            productsCollectionView.reloadData()
            removeChoices("Menu")
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if display {
            turnOnMenu()
        } else {
            dropDown.hide()
            self.products = productController.products!
            productsCollectionView.reloadData()
            removeChoices("Menu")
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
