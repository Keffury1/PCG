//
//  MembershipViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 1/26/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class MembershipViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var learnMoreButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.init(named: "Navy")?.cgColor
        loginButton.addShadow()
        learnMoreButton.layer.cornerRadius = 10.0
        learnMoreButton.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func learnMoreButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
