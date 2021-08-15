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
    
    var parentVC: UIViewController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        self.isModalInPresentation = true
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.init(named: "Navy")?.cgColor
        loginButton.addShadow()
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        parentVC?.tabBarController?.selectedIndex = 1
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // FaceID
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // SignUP
//        UserDefaults.setValue("User is now member", forKey: "Member")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
