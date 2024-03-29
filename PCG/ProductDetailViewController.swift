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
    var price: Bool?
    
    // MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var customizeButton: UIButton!
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceWithSubLabel: UILabel!
    @IBOutlet weak var withSubLabel: UILabel!
    @IBOutlet weak var productDetailCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupSubviews()
        productDetailCollectionView.dataSource = self
        productDetailCollectionView.delegate = self
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        customizeButton.layer.cornerRadius = 15
        customizeButton.addShadow()
        
        guard let product = product else { return }
        
        if price! {
            priceLabel.text = "$\(product.price)"
            priceWithSubLabel.text = "$\(product.discountPrice)"
            priceWithSubLabel.isHidden = false
            withSubLabel.isHidden = false
            withSubLabel.alpha = 1
        } else {
            priceLabel.text = ""
            priceWithSubLabel.text = ""
            priceWithSubLabel.isHidden = true
            withSubLabel.isHidden = true
            withSubLabel.alpha = 0
        }
    }
    
    private func updateViews() {
        guard let product = product else { return }
        
        productImageView.image = UIImage(named: product.image)
        productImageView.layer.cornerRadius = 20.0
        productImageView.clipsToBounds = true
        productTitleLabel.text = product.name
        productDescriptionTextView.text = product.description
    }
    
    // MARK: - Actions
    
    @IBAction func customizeButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "customizeSegue", sender: self)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productImageCell", for: indexPath) as? ProductDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.productDetailImageView.image = UIImage(named: product!.image)
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.productDetailImageView.layer.cornerRadius = 10
        cell.productDetailImageView.layer.masksToBounds = true
        cell.layer.masksToBounds = true
        
        if cell.isSelected {
            cell.layer.borderColor = UIColor(named: "Navy")!.cgColor
        }else {
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(named: "Navy")!.cgColor
        cell?.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.isSelected = false
    }
}
