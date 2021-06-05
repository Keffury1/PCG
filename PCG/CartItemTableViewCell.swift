//
//  CartItemTableViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 6/5/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        
    }
}
