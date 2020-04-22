//
//  ProductCollectionViewCell.swift
//  PCG
//
//  Created by Bobby Keffury on 4/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped: UIButton)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var delegate: CollectionViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    //MARK: - Actions
    @IBAction func infoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        self.delegate?.collectionViewCell(self, buttonTapped: editButton)
    }
}
