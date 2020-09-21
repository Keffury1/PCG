//
//  CartItemTableViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 9/21/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
