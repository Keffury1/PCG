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
    
    // MARK: - Outlets
    
    @IBOutlet weak var bottomFadeView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var customizerView: UIView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        templatesCollectionView.dataSource = self
        templatesCollectionView.delegate = self
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
    
    private func addCustomization(for template: Template) {
        for need in template.needs {
            switch need {
            case .hisFirstName:
                addTextFieldToCustomizer(need: .hisFirstName)
            case .hisLastName:
                addTextFieldToCustomizer(need: .hisLastName)
            case .hisLastInitial:
                addTextFieldToCustomizer(need: .hisLastInitial)
            case .herFirstName:
                addTextFieldToCustomizer(need: .herFirstName)
            case .herLastName:
                addTextFieldToCustomizer(need: .herLastName)
            case .fullName:
                addTextFieldToCustomizer(need: .fullName)
            case .photo:
                return
            case .initials:
                addTextFieldToCustomizer(need: .initials)
            case .shortDate:
                addPickerToCustomizer(need: .shortDate)
            case .longDate:
                addPickerToCustomizer(need: .longDate)
            case .address:
                addTextFieldToCustomizer(need: .address)
            case .state:
                addPickerToCustomizer(need: .state)
            case .year:
                addPickerToCustomizer(need: .year)
            case .monthYear:
                addPickerToCustomizer(need: .monthYear)
            }
        }
    }
    
    private func addPickerToCustomizer(need: Need) {
        switch need {
        case .shortDate:
            return
        case .longDate:
            return
        case .state:
            return
        case .year:
            return
        case .monthYear:
            return
        default:
            return
        }
    }
    
    private func addTextFieldToCustomizer(need: Need) {
        switch need {
        case .initials:
            return
        case .hisLastInitial:
            return
        default:
            return
        }
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
            addCustomization(for: template)
        }
    }
}
