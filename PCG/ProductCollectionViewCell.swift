//
//  ProductCollectionViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        setupSubviews()
    }
    
    private func setupSubviews() {
        productImageView.layer.shadowColor = UIColor.black.cgColor
        productImageView.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        productImageView.layer.shadowRadius = 5
        productImageView.layer.shadowOpacity = 0.4

    }
}
