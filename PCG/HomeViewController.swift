//
//  HomeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var membershipButton: UIButton!
    @IBOutlet weak var shopButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    func setupSubviews() {
        let gradient = CAGradientLayer()

        gradient.frame = headerView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(named: "Light Gray")!.cgColor]

        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        membershipButton.layer.cornerRadius = 15
        membershipButton.layer.shadowColor = UIColor.black.cgColor
        membershipButton.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        membershipButton.layer.shadowRadius = 5
        membershipButton.layer.shadowOpacity = 0.25
        
        shopButton.layer.cornerRadius = 15
        shopButton.layer.shadowColor = UIColor.black.cgColor
        shopButton.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        shopButton.layer.shadowRadius = 5
        shopButton.layer.shadowOpacity = 0.25
    }
    
    // MARK: - Actions
    
    @IBAction func membershipButtonTapped(_ sender: Any) {
    }
    
    @IBAction func shopButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
