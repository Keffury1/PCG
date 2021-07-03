//
//  ShopViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import DropDown

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let productController = ProductController()
    var price: Bool = true
    var display: Bool = true
    var products: [Product] = []
    var product: Product?
    var cart: [Product]?
    let dropDown = DropDown()
    
    // MARK: - Outlets

    @IBOutlet var productButtonCollection: [UIButton]!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lowToHighButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var cartButton: SSBadgeButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var menuLabel: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var choicesView: UIView!
    @IBOutlet weak var cuttingBoardsButton: UIButton!
    @IBOutlet weak var cheeseBoardsButton: UIButton!
    @IBOutlet weak var knifeSetsButton: UIButton!
    @IBOutlet weak var ornamentsButton: UIButton!
    @IBOutlet weak var doormatsButton: UIButton!
    @IBOutlet weak var stampsButton: UIButton!
    @IBOutlet weak var dogTreatJarButton: UIButton!
    @IBOutlet weak var lanternButton: UIButton!
    @IBOutlet weak var showAllButton: UIButton!
    
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
    }
    
    // MARK: - Collection View Methods
   
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
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        highToLowButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        setupButtons()
        choicesView.layer.cornerRadius = 10.0
        menuLabel.addShadow()
    }
    
    func setupButtons() {
        menuLabel.layer.cornerRadius = 10.0
        cuttingBoardsButton.layer.cornerRadius = 10.0
        cheeseBoardsButton.layer.cornerRadius = 10.0
        knifeSetsButton.layer.cornerRadius = 10.0
        ornamentsButton.layer.cornerRadius = 10.0
        doormatsButton.layer.cornerRadius = 10.0
        stampsButton.layer.cornerRadius = 10.0
        dogTreatJarButton.layer.cornerRadius = 10.0
        lanternButton.layer.cornerRadius = 10.0
        showAllButton.layer.cornerRadius = 10.0
    }
    
    func enableButtons() {
        cuttingBoardsButton.isEnabled = true
        cheeseBoardsButton.isEnabled = true
        knifeSetsButton.isEnabled = true
        ornamentsButton.isEnabled = true
        doormatsButton.isEnabled = true
        stampsButton.isEnabled = true
        dogTreatJarButton.isEnabled = true
        lanternButton.isEnabled = true
        showAllButton.isEnabled = true
    }
    
    func disableButtons() {
        cuttingBoardsButton.isEnabled = false
        cheeseBoardsButton.isEnabled = false
        knifeSetsButton.isEnabled = false
        ornamentsButton.isEnabled = false
        doormatsButton.isEnabled = false
        stampsButton.isEnabled = false
        dogTreatJarButton.isEnabled = false
        lanternButton.isEnabled = false
        showAllButton.isEnabled = false
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
        disableButtons()
        display = true
        menuLabel.setTitle(string, for: .normal)
    }
    
    func turnOnMenu() {
        
        var items: [String] = []
        for product in products {
            if items.contains(product.category) {
                
            } else {
                items.append(product.category)
            }
        }
        dropDown.anchorView = menuButton
        dropDown.backgroundColor = UIColor(named: "Navy")
        dropDown.textColor = .white
        dropDown.dataSource = items.sorted { $0 < $1 }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            removeChoices(item)
            sortByCategory(category: item)
        }
        dropDown.cornerRadius = 10
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
