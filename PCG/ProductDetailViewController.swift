//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    
    // MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var customizeButton: UIButton!
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceWithSubLabel: UILabel!
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupSubviews()
        productDetailCollectionView.dataSource = self
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        customizeButton.layer.cornerRadius = 15
        customizeButton.addShadow()
        
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
        
        
        guard let product = product else { return }
        
        
        priceLabel.text = "$\(String(format: "%.0f", product.price))"
        
        priceWithSubLabel.text = "$\(String(format: "%.0f", product.twentyUnitPrice))"
    }
    
    private func updateViews() {
        guard let product = product else { return }
        
        productImageView.image = product.image
        productImageView.layer.cornerRadius = 20.0
        productImageView.clipsToBounds = true
        productTitleLabel.text = product.title
        productDescriptionTextView.text = product.description
    }
    
    // MARK: - Actions
    
    @IBAction func customizeButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "customizeSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeSegue" {
            if let customizeVC = segue.destination as? CustomizeViewController, let product = product {
                customizeVC.product = product
            }
        }
    }

}

extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productDetailCell", for: indexPath) as? ProductDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let image = product?.images?[indexPath.row]
        cell.productDetailImageView.image = image
        return cell
    }
    
    
}
