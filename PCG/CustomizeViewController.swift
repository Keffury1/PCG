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
import ProgressHUD
import VerticalSlider

class CustomizeViewController: UIViewController {
    
    // MARK: - Properties
    
    let scrollImg = UIScrollView()
    var product: Product?
    var template: Template?
    var indexPath: IndexPath?
    var reset: Bool = false
    var first: Bool = true
    
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
    @IBOutlet weak var templatesCollectionView: UICollectionView!
    @IBOutlet weak var chooseTemplateView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var verticalSlider: VerticalSlider!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        first = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if product?.templates?.count == 1 {
            let indexPath = self.templatesCollectionView.indexPathsForSelectedItems?.first ?? IndexPath(item: 0, section: 0)
            self.templatesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            collectionView(templatesCollectionView, didSelectItemAt: indexPath)
        }
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        guard let product = product else { return }
        
        if product.templates?.isEmpty == true {
            return
        } else {
            firstTemplateImageView.image = UIImage(named: (product.templates?.first!.name) ?? "")
        }
        
        let vWidth = self.templateContainerView.frame.width
        let vHeight = self.templateContainerView.frame.height
        
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.showsHorizontalScrollIndicator = false
        
        scrollImg.minimumZoomScale = 1
        scrollImg.maximumZoomScale = 10
        
        templateContainerView.addSubview(scrollImg)
        templateContainerView.layer.cornerRadius = 10
        templateContainerView.clipsToBounds = true
        firstTemplateImageView.layer.cornerRadius = 10
        firstTemplateImageView.clipsToBounds = true
        scrollImg.addSubview(firstTemplateImageView)
        
        templatesCollectionView.dataSource = self
        templatesCollectionView.delegate = self
        
        continueButton.layer.cornerRadius = 10
        continueButton.addShadow()
        
        verticalSlider.slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    private func enableContinueButton() {
        continueButton.setTitle(" Continue", for: .normal)
        continueButton.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.tintColor = .white
        continueButton.backgroundColor = UIColor(named: "Navy")!
        continueButton.isUserInteractionEnabled = true
    }
    
    private func disableContinueButton() {
        continueButton.setTitle(" Choose Template", for: .normal)
        continueButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        continueButton.setTitleColor(UIColor(named: "Navy")!, for: .normal)
        continueButton.tintColor = UIColor(named: "Navy")!
        continueButton.backgroundColor = UIColor(named: "Tan")!
        continueButton.isUserInteractionEnabled = false
    }
    
    @objc private func sliderChanged() {
        scrollImg.setZoomScale(CGFloat(verticalSlider.value), animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func continueButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "step2Segue", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "step2Segue" {
            if let detailVC = segue.destination as? CustomizeTwoViewController {
                detailVC.product = product
                detailVC.template = template
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
            reset = true
            view.reloadInputViews()
            enableContinueButton()
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? TemplateCollectionViewCell
        cell?.layer.borderColor = UIColor(named: "Navy")!.cgColor
        cell?.isSelected = true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TemplateCollectionViewCell
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.isSelected = false
        disableContinueButton()
    }
}

extension CustomizeViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.firstTemplateImageView
    }
}
