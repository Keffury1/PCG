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
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var customizeButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        customizeButton.layer.cornerRadius = 15
        customizeButton.addShadow()
        
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.addShadow()
        
        
    }
    
    private func updateViews() {
        guard let product = product else { return }
        
        productImageView.image = product.image
        productTitleLabel.text = product.title
        productDescriptionTextView.text = product.description
        productPriceLabel.text = "\(product.price)"
    }
    
    // MARK: - Actions
    
    @IBAction func customizeButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
