//
//  CartViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 9/21/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var enterCardDetailsButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        setupSubviews()
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        applePayButton.layer.cornerRadius = 10.0
        enterCardDetailsButton.layer.cornerRadius = 10.0
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
    }
    
    // MARK: - Actions
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
