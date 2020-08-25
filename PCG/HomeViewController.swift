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
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var membershipView: UIView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet var membershipTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var shopTapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        let gradient = CAGradientLayer()

        gradient.frame = headerView.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.init(named: "Light Gray")!.cgColor]

        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0)
        headerView.layer.insertSublayer(gradient, at: 0)
        
        membershipView.layer.cornerRadius = 15
        membershipView.layer.shadowColor = UIColor.black.cgColor
        membershipView.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        membershipView.layer.shadowRadius = 5
        membershipView.layer.shadowOpacity = 0.25
        
        shopView.layer.cornerRadius = 15
        shopView.layer.shadowColor = UIColor.black.cgColor
        shopView.layer.shadowOffset = CGSize(width: 2.0, height: 6.0)
        shopView.layer.shadowRadius = 5
        shopView.layer.shadowOpacity = 0.25
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
