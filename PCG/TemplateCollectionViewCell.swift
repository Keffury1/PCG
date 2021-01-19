//
//  TemplateCollectionViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 1/19/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class TemplateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var templateImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        setupSubviews()
    }
    
    private func setupSubviews() {
        templateImageView.layer.shadowColor = UIColor.black.cgColor
        templateImageView.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        templateImageView.layer.shadowRadius = 5
        templateImageView.layer.shadowOpacity = 0.25
    }
}
