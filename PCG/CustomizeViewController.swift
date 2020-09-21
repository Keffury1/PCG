//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/28/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import MobileBuySDK

class CustomizeViewController: UIViewController {

    // MARK: - Properties
    
    var product: Product?
    var shopify = Shopify()
    
    // MARK: - Outlets
    
    @IBOutlet weak var name: UILabel!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func updateViews() {
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
