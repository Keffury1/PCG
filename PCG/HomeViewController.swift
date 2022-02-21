//
//  HomeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import LocalAuthentication
import ProgressHUD
import SafariServices

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let reviewController = ReviewController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var shopButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewController.loadReviews()
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logoImageView.layer.cornerRadius = 10
        logoImageView.clipsToBounds = true
        logoImageView.addShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupSubviews()
    }
    
    // MARK: - Colllection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let reviews = reviewController.reviews {
            return reviews.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
        
        guard let reviews = reviewController.reviews else { return UICollectionViewCell() }
        let review = reviews[indexPath.row]
        cell.nameLabel.text = review.username
        cell.reviewView.text = review.review
        cell.layer.cornerRadius = 10.0
        cell.addTopDownGradient(color: UIColor.init(named: "Tan")!.cgColor)
        cell.reviewView.textContainer.lineBreakMode = .byTruncatingTail
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 120)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        shopView.roundCorners(corners: [.topRight, .topLeft], radius: 15)
        shopButton.setTitle("", for: .normal)
    }
    
    private func loginMember() {
        if UserDefaults.value(forKey: "Member") != nil {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [weak self] success, authenticationError in
                    
                    DispatchQueue.main.async {
                        if success {
                            self?.login()
                        } else {
                            ProgressHUD.showError("Error Logging in", image: nil, interaction: false)
                        }
                    }
                }
            } else {
                ProgressHUD.showError("No Biometry", image: nil, interaction: false)
            }
        }
    }
    
    private func login() {
        UserDefaults.setValue("User logged in", forKey: "LoggedIn")
    }
    
    // MARK: - Actions
    
    @IBAction func shopButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
