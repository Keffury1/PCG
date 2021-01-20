//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 10/13/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CustomizeViewController: UIViewController {
    // MARK: - Properties
    
    var product: Product?
    var template: Template?
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var customizerTableView: UITableView!
    @IBOutlet weak var customizeTextFieldView: UIView!
    @IBOutlet weak var customizeTextField: UITextField!
    @IBOutlet weak var saveCustomTextButton: UIButton!
    @IBOutlet weak var customizeDateView: UIView!
    @IBOutlet weak var customizeDatePicker: UIDatePicker!
    @IBOutlet weak var saveCustomDateButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        customizeTextField.delegate = self
        templatesCollectionView.dataSource = self
        templatesCollectionView.delegate = self
        customizerTableView.dataSource = self
        customizerTableView.delegate = self
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.addShadow()
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
        firstTemplateImageView.layer.cornerRadius = 10
        firstTemplateImageView.clipsToBounds = true
    }
    
    private func updateViews() {
        guard let product = product else { return }
        firstTemplateImageView.image = product.templates?.first?.image
    }
    
    func switchDatePicker() {
        if customizeDateView.alpha == 1 {
            customizeDateView.alpha = 0
            customizeDateView.isUserInteractionEnabled = false
        } else {
            customizeDateView.alpha = 1
            customizeDateView.isUserInteractionEnabled = true
        }
    }
    
    func switchTextField() {
        if customizerTableView.alpha == 1 {
            customizerTableView.alpha = 0
            customizerTableView.isUserInteractionEnabled = false
        } else {
            customizerTableView.alpha = 1
            customizerTableView.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveCustomTextButtonTapped(_ sender: Any) {
        switchTextField()
    }
    
    @IBAction func saveCustomDateButtonTapped(_ sender: Any) {
        switchDatePicker()
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
            cell.templateImageView.image = template.image
            cell.templateImageView.layer.cornerRadius = 10
            cell.templateImageView.clipsToBounds = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = product else { return }
        if let template = product.templates?[indexPath.row] {
            firstTemplateImageView.image = template.image
            self.template = template
            self.customizerTableView.reloadData()
        }
    }
}

extension CustomizeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return template?.needs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customizerCell", for: indexPath) as? CustomizerTableViewCell else { return UITableViewCell() }
        
        if let need = template?.needs[indexPath.row] {
            cell.needLabel.text = need.rawValue
            cell.needImageView.image = UIImage.init(named: "\(need.rawValue)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let need = template?.needs[indexPath.row] {
            switch need {
            case .hisFirstName:
                switchTextField()
            case .hisLastName:
                switchTextField()
            case .hisLastInitial:
                switchTextField()
            case .herFirstName:
                switchTextField()
            case .herLastName:
                switchTextField()
            case .fullName:
                switchTextField()
            case .photo:
                return
            case .initials:
                switchTextField()
            case .shortDate:
                switchDatePicker()
            case .longDate:
                switchDatePicker()
            case .address:
                switchTextField()
            case .state:
                return
            case .year:
                switchDatePicker()
            case .monthYear:
                switchDatePicker()
            }
        }
    }
}

extension CustomizeViewController: UITextFieldDelegate {
    
}
