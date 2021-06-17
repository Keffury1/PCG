//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 10/13/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SMSegmentView

class CustomizeViewController: UIViewController {
    // MARK: - Properties
    
    var product: Product?
    var template: Template?
    var indexPath: IndexPath?
    var reset: Bool = false
    var first: Bool = true
    var entries: [Int:String] = [:]
    
    // MARK: - Outlets
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var chooseTemplateView: UIView!
    @IBOutlet weak var addInfoView: UIView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        updateViews()
        first = false
        bottomFadeView.addBottomUpGradient(color: UIColor(named: "Tan")!.cgColor)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        
        templatesCollectionView.dataSource = self
        templatesCollectionView.delegate = self
        
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.addShadow()
        addToCartButton.isEnabled = false
        addToCartButton.setTitle("", for: .normal)
        addToCartButton.tintColor = UIColor.init(named: "Navy")
        
        firstTemplateImageView.layer.cornerRadius = 10
        firstTemplateImageView.clipsToBounds = true
    }
    
    private func updateViews() {
        guard let product = product else { return }
        if product.templates?.isEmpty == true {
            return
        } else {
            firstTemplateImageView.image = UIImage(named: (product.templates?.first!.name) ?? "")
        }
    }
    
    func addToCartOn() {
        addToCartButton.isEnabled = true
        addToCartButton.setTitle("  Add to Cart", for: .normal)
    }
    
    func addToCartOff() {
        addToCartButton.isEnabled = false
        addToCartButton.setTitle("", for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension CustomizeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.templates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "templateCell", for: indexPath) as? TemplateCollectionViewCell else { return UICollectionViewCell() }
        guard let product = product else { return UICollectionViewCell() }
        
        if let template = product.templates?[indexPath.row] {
            cell.templateImageView.image = UIImage(named: template.name)
            cell.templateImageView.layer.cornerRadius = 10
            cell.templateImageView.clipsToBounds = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = product else { return }
        
        if let template = product.templates?[indexPath.row] {
            firstTemplateImageView.image = UIImage(named: template.name)
            self.template = template
            reset = true
        }
        if addInfoView.isHidden == true {
            addInfoView.isHidden = false
        }
    }
}
