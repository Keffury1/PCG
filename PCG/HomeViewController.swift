//
//  HomeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    
    let reviewController = ReviewController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var membershipView: UIView!
    @IBOutlet weak var shopView: UIView!
    @IBOutlet var membershipTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var shopTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var viaEtsyButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        reviewController.loadReviews()
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.layer.cornerRadius = 10.0
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
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        
        membershipView.layer.cornerRadius = 15
        membershipView.addShadow()
        
        shopView.layer.cornerRadius = 15
        shopView.addShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func membershipButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func shopButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func viaEtsyButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
