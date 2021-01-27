//
//  MembershipViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 1/26/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class MembershipViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var whiteDotView: UIView!
    @IBOutlet weak var whiteLabel: UILabel!
    @IBOutlet weak var whiteTextView: UITextView!
    @IBOutlet var whiteTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var tanView: UIView!
    @IBOutlet weak var tanDotView: UIView!
    @IBOutlet var tanTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var tanLabel: UILabel!
    @IBOutlet weak var tanTextView: UITextView!
    @IBOutlet weak var navyView: UIView!
    @IBOutlet weak var navyDotView: UIView!
    @IBOutlet weak var navyLabel: UILabel!
    @IBOutlet weak var navyTextView: UITextView!
    @IBOutlet var navyTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var goldView: UIView!
    @IBOutlet weak var goldDotView: UIView!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var goldTextView: UITextView!
    @IBOutlet var goldTapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    // MARK: - Methods
    
    private func setupSubviews() {
        headerView.addTopDownGradient(color: UIColor.init(named: "Light Gray")!.cgColor)
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = UIColor.init(named: "Navy")?.cgColor
        loginButton.addShadow()
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.addShadow()
        
        whiteDotView.layer.cornerRadius = whiteDotView.frame.width / 2
        whiteDotView.layer.borderWidth = 1.0
        whiteDotView.layer.borderColor = UIColor.init(named: "Navy")?.cgColor
        whiteView.layer.cornerRadius = 10.0
        whiteView.backgroundColor = UIColor.init(named: "Navy")
        whiteLabel.textColor = .white
        whiteTextView.textColor = .white
        
        tanDotView.layer.cornerRadius = tanDotView.frame.width / 2
        tanDotView.layer.borderWidth = 1.0
        tanDotView.layer.borderColor = UIColor.white.cgColor
        tanView.layer.cornerRadius = 10.0
        
        navyDotView.layer.cornerRadius = navyDotView.frame.width / 2
        navyDotView.layer.borderWidth = 1.0
        navyDotView.layer.borderColor = UIColor.white.cgColor
        navyView.layer.cornerRadius = 10.0
        
        goldDotView.layer.cornerRadius = goldDotView.frame.width / 2
        goldDotView.layer.borderWidth = 1.0
        goldDotView.layer.borderColor = UIColor.white.cgColor
        goldView.layer.cornerRadius = 10.0
        
        whiteTapGestureRecognizer.isEnabled = true
        tanTapGestureRecognizer.isEnabled = true
        navyTapGestureRecognizer.isEnabled = true
        goldTapGestureRecognizer.isEnabled = true
    }
    
    private func allElseOff(except: UIView) {
        switch except {
        case whiteView:
            whiteView.backgroundColor = UIColor.init(named: "Navy")
            whiteLabel.textColor = .white
            whiteTextView.textColor = .white
            tanView.backgroundColor = .clear
            tanLabel.textColor = UIColor.init(named: "Navy")
            tanTextView.textColor = UIColor.init(named: "Navy")
            navyView.backgroundColor = .clear
            navyLabel.textColor = UIColor.init(named: "Navy")
            navyTextView.textColor = UIColor.init(named: "Navy")
            goldView.backgroundColor = .clear
            goldLabel.textColor = UIColor.init(named: "Navy")
            goldTextView.textColor = UIColor.init(named: "Navy")
        case tanView:
            whiteView.backgroundColor = .clear
            whiteLabel.textColor = UIColor.init(named: "Navy")
            whiteTextView.textColor = UIColor.init(named: "Navy")
            tanView.backgroundColor = UIColor.init(named: "Navy")
            tanLabel.textColor = .white
            tanTextView.textColor = .white
            navyView.backgroundColor = .clear
            navyLabel.textColor = UIColor.init(named: "Navy")
            navyTextView.textColor = UIColor.init(named: "Navy")
            goldView.backgroundColor = .clear
            goldLabel.textColor = UIColor.init(named: "Navy")
            goldTextView.textColor = UIColor.init(named: "Navy")
        case navyView:
            whiteView.backgroundColor = .clear
            whiteLabel.textColor = UIColor.init(named: "Navy")
            whiteTextView.textColor = UIColor.init(named: "Navy")
            tanView.backgroundColor = .clear
            tanLabel.textColor = UIColor.init(named: "Navy")
            tanTextView.textColor = UIColor.init(named: "Navy")
            navyView.backgroundColor = UIColor.init(named: "Navy")
            navyLabel.textColor = .white
            navyTextView.textColor = .white
            goldView.backgroundColor = .clear
            goldLabel.textColor = UIColor.init(named: "Navy")
            goldTextView.textColor = UIColor.init(named: "Navy")
        case goldView:
            whiteView.backgroundColor = .clear
            whiteLabel.textColor = UIColor.init(named: "Navy")
            whiteTextView.textColor = UIColor.init(named: "Navy")
            tanView.backgroundColor = .clear
            tanLabel.textColor = UIColor.init(named: "Navy")
            tanTextView.textColor = UIColor.init(named: "Navy")
            navyView.backgroundColor = .clear
            navyLabel.textColor = UIColor.init(named: "Navy")
            navyTextView.textColor = UIColor.init(named: "Navy")
            goldView.backgroundColor = UIColor.init(named: "Navy")
            goldLabel.textColor = .white
            goldTextView.textColor = .white
        default:
            return
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        // FaceID
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    @IBAction func whiteViewTapped(_ sender: Any) {
        allElseOff(except: whiteView)
    }
    
    @IBAction func tanViewTapped(_ sender: Any) {
        allElseOff(except: tanView)
    }
    
    @IBAction func navyViewTapped(_ sender: Any) {
        allElseOff(except: navyView)
    }
    
    @IBAction func goldViewTapped(_ sender: Any) {
        allElseOff(except: goldView)
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if let _ = segue.destination as? LoginViewController {
                
            }
        } else if segue.identifier == "signUpSegue" {
            if let _ = segue.destination as? SignUpViewController {
                
            }
        }
        
    }
}
