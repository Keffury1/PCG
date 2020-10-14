//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 10/13/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CustomizeViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    
    // MARK: - Outlets
    
    @IBOutlet weak var inscriptionTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        guard let product = product else { return }
        productImageView.image = product.blankImage
    }
    
    // MARK: - Actions
    
    @IBAction func inscriptionEditingEnded(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
