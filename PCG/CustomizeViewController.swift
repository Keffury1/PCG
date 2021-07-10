//
//  CustomizeViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 10/13/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import SMSegmentView
import FSCalendar
import IQKeyboardManagerSwift
import CoreData

class CustomizeViewController: UIViewController {
    
    // MARK: - Properties
    
    let scrollImg: UIScrollView = UIScrollView()
    var chosenTextField: UITextField?
    var count = 0
    var dateCount: Int?
    var product: Product?
    var template: Template?
    var dateDelegate: DateDelegate?
    var templateTextFieldDelegate: TemplateTextFieldDelegate?
    var indexPath: IndexPath?
    var reset: Bool = false
    var first: Bool = true
    var completedCount: Int = 0
    
    lazy var fetchedResultsController: NSFetchedResultsController<Cart> = {
        
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: false)
        ]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "name", cacheName: nil)
        try! frc.performFetch()
        return frc
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var templateContainerView: UIView!
    @IBOutlet weak var firstTemplateImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
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
        let vWidth = self.templateContainerView.frame.width
        let vHeight = self.templateContainerView.frame.height
        
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.showsHorizontalScrollIndicator = false
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        templateContainerView!.addSubview(scrollImg)
        scrollImg.addSubview(firstTemplateImageView!)
        
        templatesCollectionView.dataSource = self
        templatesCollectionView.delegate = self
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
    
    private func newTextField(image: UIImage, text: String) {
        let textFieldView = TextFieldView()
        textFieldView.iconButton.setBackgroundImage(image, for: .normal)
        textFieldView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        textFieldView.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
        customizeStackView.addArrangedSubview(textFieldView)
        textFieldView.textField.delegate = self
        textFieldView.textField.attributedPlaceholder = NSAttributedString(string: text,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textFieldView.textField.tag = count
    }
    
    private func setupCustomizer(template: Template?) {
        count = 0
        
        self.template?.fulfilled = [:]
        checkIfCustomized()
        
        scrollImg.zoomScale = 0
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
        
        customizeStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        guard let template = template else { return }
        for need in template.needs {
            count += 1
            switch need.id {
            case 1:
                //FirstName
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "First Name")
            case 2:
                //LastName
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Last Name")
            case 3:
                //LastInitial
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Last Initial")
            case 4:
                //FullName
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Full Name")
            case 5:
                //Monogram
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Monogram")
            case 6:
                //Initials
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Initials")
            case 7:
                //Date
                let dateView = DateView()
                dateView.calendarView.delegate = self
                dateView.calendarView.dataSource = self
                self.dateDelegate = dateView
                dateView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
                dateView.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(dateView)
                dateCount = count
            case 8:
                //Address
                newTextField(image: UIImage(systemName: "house.circle")!, text: "Address")
            case 9:
                //State
                let stateView = StateView()
                stateView.template = template
                stateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                stateView.widthAnchor.constraint(equalToConstant: self.customizeStackView.frame.width).isActive = true
                customizeStackView.addArrangedSubview(stateView)
                stateView.count = count
                stateView.stateTappedDelegate = self
            case 10:
                //Message
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Message")
                
                count += 1
                
                //Signature
                newTextField(image: UIImage(systemName: "pencil.circle")!, text: "Signature Line")
            case 11:
                //petName
                newTextField(image: UIImage(systemName: "hare")!, text: "Pet's Name")
            default:
                return
            }
        }
        
        countLabel.text = "\(completedCount) of \(count)"
        
        customizeStackView.axis  = NSLayoutConstraint.Axis.vertical
        customizeStackView.distribution  = UIStackView.Distribution.equalSpacing
        customizeStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func checkIfCustomized() {
        guard let template = template else { return }
        
        var message: Bool = false
        
        for need in template.needs {
            if need.id == 10 {
                message = true
            }
        }
        
        if message {
            if template.fulfilled.count == template.needs.count + 1 {
                countLabel.text = "✓ \(template.fulfilled.count) of \(template.needs.count + 1)"
                self.performSegue(withIdentifier: "reviewSegue", sender: self)
            } else {
                countLabel.text = "\(template.fulfilled.count) of \(template.needs.count + 1)"
            }
        } else {
            if template.fulfilled.count == template.needs.count {
                countLabel.text = "✓ \(template.fulfilled.count) of \(template.needs.count)"
                self.performSegue(withIdentifier: "reviewSegue", sender: self)
            } else {
                countLabel.text = "\(template.fulfilled.count) of \(template.needs.count)"
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let template = template, var product = product else { return }
        product.chosenTemplate?.append(template)
        product.count += 1
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        let moc = CoreDataStack.shared.mainContext
        let newProduct = CDProduct(category: product.category, count: Int16(product.count), descriptionText: product.description, discountPrice: Int16(product.discountPrice), id: Int16(product.id), image: product.image, name: product.name, price: Int16(product.price), context: moc)
        let newTemplate = CDTemplate(id: Int16(template.id), name: template.name, context: moc)
        newProduct.addToChosenTemplate(newTemplate)
        
        if fetchedResultsController.fetchedObjects?.isEmpty == true {
            let cart = Cart(name: "New Cart", context: moc)
            cart.addToCartProducts(newProduct)
        } else {
            fetchedResultsController.fetchedObjects?.first?.addToCartProducts(newProduct)
        }
        
        do {
            try moc.save()
        } catch {
            print("Error saving added product: \(error)")
        }
        navigationController?.popToRootViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didPressOnDoneButton() {
        guard let tf = chosenTextField else { return }
        if tf.text == "" {
            template?.fulfilled[tf.tag] = nil
        } else {
            template?.fulfilled[tf.tag] = tf.text
        }
        checkIfCustomized()
        tf.resignFirstResponder()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            if let _ = segue.destination as? ReviewViewController {
                
            }
        }
    }
}

extension CustomizeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.templates?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "templateCell", for: indexPath) as? TemplateCollectionViewCell else { return UICollectionViewCell() }
        guard let product = product else { return UICollectionViewCell() }
        
        if product.id == 1 {
            cell.templateImageView.contentMode = .scaleAspectFill
        } else if product.id == 2 {
            cell.templateImageView.contentMode = .scaleAspectFill
        } else if product.id == 4 {
            cell.templateImageView.contentMode = .scaleAspectFill
        } else {
            cell.templateImageView.contentMode = .scaleAspectFit
        }
        
        if let template = product.templates?[indexPath.row] {
            cell.templateImageView.image = UIImage(named: template.name)
            cell.templateImageView.layer.cornerRadius = 10
            cell.templateImageView.clipsToBounds = false
        }
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.templateImageView.layer.cornerRadius = 10
        cell.templateImageView.layer.masksToBounds = true
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
            setupCustomizer(template: template)
            reset = true
            view.reloadInputViews()
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

extension CustomizeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.chosenTextField = textField
        let invocation = IQInvocation(self, #selector(didPressOnDoneButton))
        textField.keyboardToolbar.doneBarButton.invocation = invocation
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            template?.fulfilled[textField.tag] = nil
        } else {
            template?.fulfilled[textField.tag] = textField.text
        }
        checkIfCustomized()
        textField.resignFirstResponder()
        return true
    }
}

extension CustomizeViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: date)
        if date == "" {
            return
        } else {
            dateDelegate?.dateTapped(date: date)
            template?.fulfilled[dateCount!] = date
            checkIfCustomized()
        }
    }
}

extension CustomizeViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.firstTemplateImageView
    }
}

extension CustomizeViewController: StateTappedDelegate {
    func stateTapped(state: String, count: Int) {
        template?.fulfilled[count] = state
        checkIfCustomized()
    }
}
