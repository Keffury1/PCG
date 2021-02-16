//
//  AccountViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 2/15/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var accountImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func editInfoButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
