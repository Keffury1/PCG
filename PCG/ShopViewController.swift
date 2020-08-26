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
    var products: [Product] = []
    
    // MARK: - Outlets

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var lowToHighButton: UIButton!
    @IBOutlet weak var highToLowButton: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        self.products = productController.products
        productsCollectionView.reloadData()
        searchTextField.addTarget(self, action: #selector(showProducts), for: .touchDown)
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
            cell.priceLabel.text = "\(product.price)"
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
    
    @IBAction func searchCompleted(_ sender: Any) {
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
        let array = productController.products.sorted(by: { $0.price < $1.price })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @IBAction func highToLowTapped(_ sender: Any) {
        let array = productController.products.sorted(by: { $0.price > $1.price })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @IBAction func groupTapped(_ sender: Any) {
        let array = productController.products.sorted(by: { $0.category.rawValue < $1.category.rawValue })
        self.products = array
        productsCollectionView.reloadData()
    }
    
    @objc func showProducts(textField: UITextField) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PopoverViewController")
        vc.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.sourceView = textField
        present(vc, animated: true, completion:nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
