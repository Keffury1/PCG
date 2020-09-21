//
//  ShopViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let productController = ProductController()
    var price: Bool = true
    var display: Bool = true
    var products: [Product] = []
    var product: Product?
    
    // MARK: - Outlets

    
    @IBOutlet var productButtonCollection: [UIButton]!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lowToHighButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
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
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        self.products = productController.products
        productsCollectionView.reloadData()
    }
    
    // MARK: - Collection View Methods
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        let product = products[indexPath.row]
        
        cell.titleLabel.text = product.title
        if price {
            cell.priceLabel.text = "$\(product.price)"
        } else {
            cell.priceLabel.text = ""
        }
        cell.productImageView.image = product.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        self.product = product
        self.performSegue(withIdentifier: "customizeSegue", sender: self)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
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
    
    func sortByCategory(category: Categories) {
        var array: [Product] = []
        for item in productController.products {
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
        dropAndRetreiveButtons()
        turnOffMenu()
    }
    
    func turnOffMenu() {
        disableButtons()
        display = true
        UIView.animate(withDuration: 0.3, animations: {
            self.menuButton.transform = self.menuButton.transform.rotated(by: CGFloat(Double.pi))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.choicesView.alpha = 0
        })
    }
    
    func turnOnMenu() {
        enableButtons()
        display = false
        UIView.animate(withDuration: 0.5, animations: {
            self.menuButton.transform = self.menuButton.transform.rotated(by: CGFloat(Double.pi))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.choicesView.alpha = 1
        })
    }
    
    func dropAndRetreiveButtons() {
        self.productButtonCollection.forEach({ (button) in
            UIView.animate(withDuration: 0.45, animations: {
                button.isHidden = !button.isHidden
            })
            if button.alpha == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.27, execute: {
                    button.alpha = 1
                })
            } else {
                button.alpha = 0
            }
        })
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
    
    @IBAction func cartTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "cartSegue", sender: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        
        dropAndRetreiveButtons()
        
        if display {
            turnOnMenu()
        } else {
            turnOffMenu()
        }
    }
    
    @IBAction func cuttingBoardButtonTapped(_ sender: Any) {
        removeChoices("Cutting Boards")
        sortByCategory(category: .CuttingBoard)
    }
    
    @IBAction func cheeseBoardButtonTapped(_ sender: Any) {
        removeChoices("Cheese Boards")
        sortByCategory(category: .CheeseBoard)
    }
    
    @IBAction func knifeSetsButtonTapped(_ sender: Any) {
        removeChoices("Knife Sets")
        sortByCategory(category: .KnifeSet)
    }
    
    @IBAction func ornamentsButtonTapped(_ sender: Any) {
        removeChoices("Ornaments")
        sortByCategory(category: .Ornament)
    }
    
    @IBAction func doormatsButtonTapped(_ sender: Any) {
        removeChoices("Doormats")
        sortByCategory(category: .Doormat)
    }
    
    @IBAction func stampsButtonTapped(_ sender: Any) {
        removeChoices("Stamps")
        sortByCategory(category: .Stamps)
    }
    
    @IBAction func dogTreatJarButtonTapped(_ sender: Any) {
        removeChoices("Dog Treat Jar")
        sortByCategory(category: .DogTreatJar)
    }
    
    @IBAction func lanternButtonTapped(_ sender: Any) {
        removeChoices("Lantern")
        sortByCategory(category: .Lantern)
    }
    
    @IBAction func showAllButtonTapped(_ sender: Any) {
        self.products = productController.products
        productsCollectionView.reloadData()
        removeChoices("Menu")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeSegue" {
            if let customizeVC = segue.destination as? CustomizeViewController {
                customizeVC.product = self.product
            }
        } 
    }
}
