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
        membershipButton.layer.borderWidth = 2.5
        membershipButton.layer.borderColor = UIColor.init(named: "Light Gray")!.cgColor
        shopButton.layer.cornerRadius = 15
        shopButton.layer.borderWidth = 2.5
        shopButton.layer.borderColor = UIColor.init(named: "Light Gray")!.cgColor
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
