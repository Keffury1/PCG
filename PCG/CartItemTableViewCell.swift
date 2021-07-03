//
//  CartItemTableViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 6/5/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

protocol UpdateDelegate {
    func updateNeeded(increase: Bool, index: Int)
}

class CartItemTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    var updateDelegate: UpdateDelegate?
    var index: Int?

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
        updateDelegate?.updateNeeded(increase: true, index: index!)
    }
    
    @IBAction func decreaseButtonTapped(_ sender: Any) {
        updateDelegate?.updateNeeded(increase: false, index: index!)
    }
}
