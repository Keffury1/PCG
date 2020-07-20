//
//  ProductsCollectionViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/20/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProductCell"

class ProductsCollectionViewController: UICollectionViewController {
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    
        let product = products[indexPath.row]
        
        cell.imageView.image = product.image
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "$ \(product.price)"
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeSegue" {
            if let customizeVC = segue.destination as? TestingViewController, let indexPaths = self.collectionView.indexPathsForSelectedItems, let index = indexPaths.first?.row {
                customizeVC.url = products[index].url
            }
        }
    }
    
}
