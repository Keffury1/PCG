//
//  CustomizerTableViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 1/19/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class CustomizerTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var needImageView: UIImageView!
    @IBOutlet weak var needLabel: UILabel!
    @IBOutlet weak var needButton: UIButton!
    
    //MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
