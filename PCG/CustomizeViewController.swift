//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 10/13/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import SMSegmentView

class CustomizeViewController: UIViewController {
    
    // MARK: - Properties
    
    var product: Product?
    var template: Template? {
        didSet {
            setupCustomizer(template: template)
        }
    }
    var indexPath: IndexPath?
    var reset: Bool = false
    var first: Bool = true
    var entries: [Int:String] = [:]
    
    // MARK: - Outlets
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var chooseTemplateView: UIView!
    @IBOutlet weak var addInfoView: UIView!
    @IBOutlet weak var customizeStackView: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        first = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubviews()
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
    }
    
    private func updateViews() {
        guard let product = product else { return }
        if product.templates?.isEmpty == true {
            return
        } else {
            firstTemplateImageView.image = UIImage(named: (product.templates?.first!.name) ?? "")
            firstTemplateImageView.layer.cornerRadius = 10
            firstTemplateImageView.clipsToBounds = true
        }
    }
    
    private func addToCartOn() {
        addToCartButton.isEnabled = true
        addToCartButton.setTitle("  Add to Cart", for: .normal)
        addToCartButton.isHidden = false
    }
    
    private func addToCartOff() {
        addToCartButton.isEnabled = false
        addToCartButton.setTitle("", for: .normal)
        addToCartButton.isHidden = true
    }
    
    private func setupCustomizer(template: Template?) {
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
        customizeStackView.subviews.forEach({ $0.removeFromSuperview() })
        guard let template = template else { return }
        for need in template.needs {
            switch need.id {
            case 1:
                //FirstName
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
                textField.textField.text = "First Name"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 2:
                //LastName
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
                textField.textField.text = "Last Name"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 3:
                //LastInitial
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "chevron.right.circle"), for: .normal)
                textField.textField.text = "Last Initial"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 4:
                //FullName
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
                textField.textField.text = "Full Name"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 6:
                //Initials
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "chevron.right.circle"), for: .normal)
                textField.textField.text = "Initials"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 7:
                //Date
                let dateView = DateView()
                dateView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
                dateView.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(dateView)
            case 8:
                //Address
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "house.circle"), for: .normal)
                textField.textField.text = "Address"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 9:
                //State
                let stateView = StateView()
                customizeStackView.addArrangedSubview(stateView)
            case 10:
                //Message
                let messageTextField = TextFieldView()
                messageTextField.iconButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
                messageTextField.textField.text = "Message"
                messageTextField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                messageTextField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(messageTextField)
                
                //Signature
                let signatureTextField = TextFieldView()
                signatureTextField.iconButton.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
                signatureTextField.textField.text = "Signature Line"
                signatureTextField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                signatureTextField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(signatureTextField)
            case 11:
                //petName
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "hare"), for: .normal)
                textField.textField.text = "Pet's Name"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            case 12:
                //Monogram
                let textField = TextFieldView()
                textField.iconButton.setBackgroundImage(UIImage(systemName: "chevron.right.circle"), for: .normal)
                textField.textField.text = "Monogram"
                textField.heightAnchor.constraint(equalToConstant: 65.0).isActive = true
                textField.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(textField)
            default:
                return
            }
        }
        customizeStackView.axis  = NSLayoutConstraint.Axis.vertical
        customizeStackView.distribution  = UIStackView.Distribution.equalSpacing
        customizeStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        if cell.isSelected {
            cell.layer.borderColor = UIColor(named: "Navy")!.cgColor
        }else {
            cell.layer.borderColor = UIColor.clear.cgColor
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
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? TemplateCollectionViewCell
        cell?.layer.borderColor = UIColor(named: "Navy")!.cgColor
        cell?.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TemplateCollectionViewCell
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.isSelected = false
    }
}
