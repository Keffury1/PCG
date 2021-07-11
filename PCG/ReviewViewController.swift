//
//  ReviewViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/10/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
