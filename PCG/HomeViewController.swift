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
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
    }
    
    // MARK: - Colllection View Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewController.reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
        
        let review = reviewController.reviews[indexPath.row]
        cell.nameLabel.text = review.name
        cell.reviewView.text = review.review
        cell.layer.cornerRadius = 10.0
        cell.addGradient(color: UIColor.init(named: "Tan")!.cgColor)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 175)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
