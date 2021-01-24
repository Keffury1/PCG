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
    var indexPath: IndexPath?
    var reset: Bool = false
    var first: Bool = true
    var entries: [Int:String] = [:]
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var abandonButton: UIButton!
    @IBOutlet weak var customizerTableView: UITableView!
    @IBOutlet weak var customizeTextFieldView: UIView!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var customizeTextField: UITextField!
    @IBOutlet weak var saveCustomTextButton: UIButton!
    @IBOutlet weak var customizeDateView: UIView!
    @IBOutlet weak var customizeDatePicker: UIDatePicker!
    @IBOutlet weak var saveCustomDateButton: UIButton!
    @IBOutlet weak var itemAddedView: UIView!
    @IBOutlet weak var viewCartButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        updateViews()
        first = false
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
        addToCartButton.isEnabled = false
        addToCartButton.setTitle("", for: .normal)
        addToCartButton.tintColor = UIColor.init(named: "Navy")
        
        bottomFadeView.addBottomUpGradient(color: UIColor.init(named: "Tan")!.cgColor)
        firstTemplateImageView.layer.cornerRadius = 10
        firstTemplateImageView.clipsToBounds = true
        
        customizeTextFieldView.layer.cornerRadius = 10
        customizeTextFieldView.layer.borderColor = UIColor.init(named: "Light Gray")?.cgColor
        customizeTextFieldView.layer.borderWidth = 2.0
        customizeTextFieldView.addShadow()
        
        
        customizeDateView.layer.cornerRadius = 10
        customizeDateView.layer.borderColor = UIColor.init(named: "Light Gray")?.cgColor
        customizeDateView.layer.borderWidth = 2.0
        customizeDateView.addShadow()
        
        abandonButton.layer.cornerRadius = 10.0
        abandonButton.isEnabled = false
        abandonButton.alpha = 0
        
        itemAddedView.isUserInteractionEnabled = false
        itemAddedView.alpha = 0
        itemAddedView.layer.cornerRadius = 10.0
    }
    
    private func updateViews() {
        guard let product = product else { return }
        firstTemplateImageView.image = product.templates?.first?.image
    }
    
    func switchDatePicker() {
        if customizeDateView.alpha == 1 {
            UIView.animate(withDuration: 0.3) {
                self.customizeDateView.alpha = 0
            }
            customizeDateView.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.customizeDateView.alpha = 1
            }
            customizeDateView.isUserInteractionEnabled = true
        }
    }
    
    func switchTextField() {
        if customizeTextFieldView.alpha == 1 {
            UIView.animate(withDuration: 0.3) {
                self.customizeTextFieldView.alpha = 0
            }
            customizeTextFieldView.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.customizeTextFieldView.alpha = 1
            }
            customizeTextFieldView.isUserInteractionEnabled = true
            customizeTextField.becomeFirstResponder()
        }
    }
    
    func switchItemAdded() {
        if itemAddedView.alpha == 1 {
            UIView.animate(withDuration: 0.3) {
                self.itemAddedView.alpha = 0
            }
            itemAddedView.isUserInteractionEnabled = false
        } else {
            UIView.animate(withDuration: 0.3) {
                self.itemAddedView.alpha = 1
            }
            itemAddedView.isUserInteractionEnabled = true
        }
    }
    
    func addToCartOn() {
        addToCartButton.isEnabled = true
        addToCartButton.setTitle("  Add to Cart", for: .normal)
        addToCartButton.tintColor = .white
    }
    
    func addToCartOff() {
        addToCartButton.isEnabled = false
        addToCartButton.setTitle("", for: .normal)
        addToCartButton.tintColor = UIColor.init(named: "Navy")
    }
    
    func dataEntered() {
        if abandonButton.alpha == 0 {
            abandonButton.alpha = 1
            abandonButton.isEnabled = true
            templatesCollectionView.isUserInteractionEnabled = false
        } else {
            return
        }
    }
    
    func abandonCustomization() {
        reset = true
        customizerTableView.setContentOffset(.zero, animated: true)
        customizerTableView.reloadData()
        abandonButton.alpha = 0
        abandonButton.isEnabled = false
        templatesCollectionView.isUserInteractionEnabled = true
        customizeDatePicker.setDate(Date(), animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        
        guard entries.values.count == template?.needs.count, var product = product else { return }
        
        for entry in entries.values {
            template?.fulfilled.append(entry.description)
        }
        product.chosenTemplate = template
        Global.sharedInstance.cart.append(product)
        switchItemAdded()
    }
    
    @IBAction func saveCustomTextButtonTapped(_ sender: Any) {
        if let entry = customizeTextField.text {
            if entry == "" {
                switchTextField()
                return
            }
            
            if let indexPath = indexPath {
                guard let cell = customizerTableView.cellForRow(at: indexPath) as? CustomizerTableViewCell else { return }
                cell.needLabel.text = entry
                cell.needButton.imageView?.image = UIImage.init(systemName: "checkmark.circle")
                entries[indexPath.row] = entry
            }
        }
        
        customizeTextField.text = nil
        switchTextField()
        dataEntered()
        if entries.count == template?.needs.count {
            addToCartOn()
        }
    }
    
    @IBAction func saveCustomDateButtonTapped(_ sender: Any) {
        let date = customizeDatePicker.date
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        if let indexPath = indexPath {
            guard let cell = customizerTableView.cellForRow(at: indexPath) as? CustomizerTableViewCell else { return }
            cell.needLabel.text = formatter.string(from: date)
            cell.needButton.imageView?.image = UIImage.init(systemName: "checkmark.circle")
            entries[indexPath.row] = formatter.string(from: date)
        }
        
        switchDatePicker()
        dataEntered()
        if entries.count == template?.needs.count {
            addToCartOn()
        }
    }
    
    @IBAction func abandonButtonTapped(_ sender: Any) {
        abandonCustomization()
        addToCartOff()
        entries = [:]
    }
    
    @IBAction func viewCartButtonTapped(_ sender: Any) {
        switchItemAdded()
        self.performSegue(withIdentifier: "viewCartSegue", sender: self)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        switchItemAdded()
        addToCartOff()
        abandonCustomization()
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
            reset = true
            customizerTableView.setContentOffset(.zero, animated: true)
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
            if reset {
                cell.needLabel.text = need.rawValue
                cell.needButton.imageView?.image = UIImage.init(systemName: "circle")
            } else {
                if entries[indexPath.row] != nil {
                    cell.needLabel.text = entries[indexPath.row]
                    cell.needButton.imageView?.image = UIImage.init(systemName: "checkmark.circle")
                } else {
                    cell.needLabel.text = need.rawValue
                    cell.needButton.imageView?.image = UIImage.init(systemName: "circle")
                }
            }
            switch need {
            case .firstName:
                cell.needImageView.image = UIImage.init(systemName: "signature")
            case .lastName:
                cell.needImageView.image = UIImage.init(systemName: "signature")
            case .lastInitial:
                cell.needImageView.image = UIImage.init(systemName: "signature")
            case .fullName:
                cell.needImageView.image = UIImage.init(systemName: "signature")
            case .photo:
                cell.needImageView.image = UIImage.init(systemName: "camera")
            case .initials:
                cell.needImageView.image = UIImage.init(systemName: "signature")
            case .date:
                cell.needImageView.image = UIImage.init(systemName: "calendar.circle")
            case .address:
                cell.needImageView.image = UIImage.init(systemName: "house.circle")
            case .state:
                cell.needImageView.image = UIImage.init(systemName: "mappin.circle")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        self.reset = false
        if let need = template?.needs[indexPath.row] {
            switch need {
            case .firstName:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .lastName:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .lastInitial:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .fullName:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .photo:
                return
            case .initials:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .date:
                switchDatePicker()
            case .address:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            case .state:
                enterLabel.text = "Enter \(need.rawValue)"
                customizeTextField.placeholder = need.rawValue
                switchTextField()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension CustomizeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let entry = textField.text {
            if entry == "" {
                switchTextField()
                return true
            } else {
                if let indexPath = indexPath {
                    guard let cell = customizerTableView.cellForRow(at: indexPath) as? CustomizerTableViewCell else { return false }
                    cell.needLabel.text = entry
                    cell.needButton.imageView?.image = UIImage.init(systemName: "checkmark.circle")
                    entries[indexPath.row] = entry
                }
            }
        }
        
        switchTextField()
        dataEntered()
        textField.text = nil
        return true
    }
}
