//
//  ProductCollectionViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 4/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
    }
}
