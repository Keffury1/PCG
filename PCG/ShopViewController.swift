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
    
    // MARK: - Outlets

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lowToHighButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
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
    
    // MARK: - Methods
    
    private func setupSubviews() {
        let gradient = CAGradientLayer()

        gradient.frame = headerView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(named: "Light Gray")!.cgColor]

        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        headerView.layer.insertSublayer(gradient, at: 0)
        highToLowButton.transform = CGAffineTransform(scaleX: -1, y: 1)
        setupButtons()
        choicesView.layer.cornerRadius = 10.0
    }
    
    func setupButtons() {
        menuButton.layer.cornerRadius = 10.0
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
        productsCollectionView.reloadData()
    }
    
    func removeChoices(_ string: String) {
        disableButtons()
        display = true
        choicesView.alpha = 0
        menuButton.setTitle(string, for: .normal)
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
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        if filterView.alpha == 0 {
            filterView.alpha = 1
            lowToHighButton.isEnabled = true
            highToLowButton.isEnabled = true
            groupButton.isEnabled = true
        } else {
            filterView.alpha = 0
            lowToHighButton.isEnabled = false
            highToLowButton.isEnabled = false
            groupButton.isEnabled = false
        }
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
    
    @IBAction func groupTapped(_ sender: Any) {
        let array = self.products.sorted(by: { $0.category.rawValue < $1.category.rawValue })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        if display {
            choicesView.alpha = 1
            enableButtons()
            display = false
            menuButton.setTitle("Menu", for: .normal)
        } else {
            choicesView.alpha = 0
            disableButtons()
            display = true
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
        removeChoices("Menu")
        self.products = productController.products
        productsCollectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
