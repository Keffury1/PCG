//
//  CustomizeTwoViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 7/16/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import SMSegmentView
import FSCalendar
import IQKeyboardManagerSwift
import CoreData
import ProgressHUD

class CustomizeTwoViewController: UIViewController {

    // MARK: - Properties
    
    var chosenTextField: UITextField?
    var count = 0
    var dateCount: Int?
    var product: Product?
    var template: Template?
    var dateDelegate: DateDelegate?
    var templateTextFieldDelegate: TemplateTextFieldDelegate?
    var indexPath: IndexPath?
    var completedCount: Int = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var templateImageView: UIImageView!
    @IBOutlet weak var customizeStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reviewButton: UIButton!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupCustomizer(template: template)
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        guard let template = template else { return }
        
        templateImageView.image = UIImage(named: template.name)
        
        reviewButton.layer.cornerRadius = 10
        reviewButton.addShadow()
        reviewButton.isUserInteractionEnabled = false
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
        
        if checkIfCustomized() {
            toggleReviewButton()
        }
        
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
                dateView.heightAnchor.constraint(equalToConstant: 275.0).isActive = true
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
        
        customizeStackView.axis  = NSLayoutConstraint.Axis.vertical
        customizeStackView.distribution  = UIStackView.Distribution.equalSpacing
        customizeStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func checkIfCustomized() -> Bool {
        guard let template = template else { return false }
        
        var message: Bool = false
        
        for need in template.needs {
            if need.id == 10 {
                message = true
            }
        }
        
        if message {
            if template.fulfilled.count == template.needs.count + 1 {
                product?.chosenTemplate = []
                product?.chosenTemplate?.append(template)
                return true
            } else {
                return false
            }
        } else {
            if template.fulfilled.count == template.needs.count {
                product?.chosenTemplate = []
                product?.chosenTemplate?.append(template)
                return true
            } else {
                return false
            }
        }
    }
    
    @objc func didPressOnDoneButton() {
        guard let tf = chosenTextField else { return }
        if tf.text == "" {
            template?.fulfilled[tf.tag] = nil
        } else {
            template?.fulfilled[tf.tag] = tf.text
        }
        if checkIfCustomized() {
            toggleReviewButton()
        }
        tf.resignFirstResponder()
    }
    
    private func toggleReviewButton() {
        if reviewButton.isUserInteractionEnabled == false {
            reviewButton.setTitle(" Review", for: .normal)
            reviewButton.setImage(UIImage(systemName: "doc.text.magnifyingglass"), for: .normal)
            reviewButton.backgroundColor = UIColor(named: "Navy")!
            reviewButton.setTitleColor(.white, for: .normal)
            reviewButton.tintColor = .white
            reviewButton.isUserInteractionEnabled = true
        } else {
            reviewButton.setTitle(" Customize", for: .normal)
            reviewButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
            reviewButton.backgroundColor = UIColor(named: "Tan")!
            reviewButton.setTitleColor(UIColor(named: "Navy")!, for: .normal)
            reviewButton.tintColor = UIColor(named: "Navy")!
            reviewButton.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func reviewButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "reviewSegue", sender: self)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewSegue" {
            if let detailVC = segue.destination as? ReviewViewController {
                detailVC.product = product
                detailVC.template = template
            }
        }
    }

}

extension CustomizeTwoViewController: UITextFieldDelegate {
    
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
        if checkIfCustomized() {
            toggleReviewButton()
        }
        textField.resignFirstResponder()
        return true
    }
}

extension CustomizeTwoViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: date)
        if date == "" {
            return
        } else {
            dateDelegate?.dateTapped(date: date)
            template?.fulfilled[dateCount!] = date
            if checkIfCustomized() {
                toggleReviewButton()
            }
        }
    }
}

extension CustomizeTwoViewController: StateTappedDelegate {
    func stateTapped(state: String, count: Int) {
        template?.fulfilled[count] = state
        if checkIfCustomized() {
            toggleReviewButton()
        }
    }
}
