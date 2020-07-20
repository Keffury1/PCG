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
    
    var products: [Product] = [
    Product(name: "Maple Cutting Board", price: 20, image: UIImage(named: "maple")!, url: "https://g3d-app.com/s/app/acp3_2/en_IPZ/y8zq61n357n0f25.html#p=1496380"),
    Product(name: "Bamboo Cutting Board", price: 40, image: UIImage(named: "bamboo")!, url: "https://g3d-app.com/s/app/acp3_2/en_PTS/whyr4g2vnfyzm7b.html#p=1613891"),
    Product(name: "Marblewood Cheese Board", price: 15, image: UIImage(named: "cheese")!, url: "https://g3d-app.com/s/app/acp3_2/en_GB/t14w79fkfnxq7px.html#p=1468069")
    ]
    
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
    
        let product = products[indexPath.row]
        
        cell.imageView.image = product.image
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "$ \(product.price)"

        cell.layer.cornerRadius = 15.0
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        self.index = indexPath.row
        self.performSegue(withIdentifier: "customizeSegue", sender: self)
        return true
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customizeSegue" {
            if let customizeVC = segue.destination as? TestingViewController {
                customizeVC.url = products[self.index!].url
            }
        }
    }
    
}
