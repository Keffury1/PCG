//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 9/21/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    // MARK: - Properties
    
    var key: Int = 1
    var addBadgeDelegate: AddBadgeToButtonDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var enterCardDetailsButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        setupSubviews()
        updateTotal()
        cartCollectionView.reloadData()
        updateTotal()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        addBadgeDelegate?.addBadgeToButton()
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.sharedInstance.cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartCell", for: indexPath) as? CartItemCollectionViewCell else { return UICollectionViewCell() }
        
        let product = Global.sharedInstance.cart[indexPath.row]
        cell.productImageView.image = product.chosenTemplate?.image ?? product.image
        cell.productTitleLabel.text = product.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 185)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        applePayButton.layer.cornerRadius = 15.0
        applePayButton.addShadow()
        enterCardDetailsButton.layer.cornerRadius = 15.0
        enterCardDetailsButton.addShadow()
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
    }
    
    private func updateTotal() {
        var count: Double = 0.00
        var items: Int = 0
        for product in Global.sharedInstance.cart {
            items += 1
            count += product.price
        }
        
        let doubleString = String(format: "%.2f", count)
        if items == 1 {
            itemsLabel.text = " \(items) item"
        } else {
            itemsLabel.text = " \(items) items"
        }
        totalLabel.text = "\(doubleString)"
    }
    
    private func deleteItem() {
        Global.sharedInstance.cart.remove(at: Int())
        cartCollectionView.reloadData()
        updateTotal()
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
