//
//  TextFieldView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    //MARK: - Properties
    
    var title: String?
    
    //MARK: - Outlets
    
    @IBOutlet var textFieldView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        addSubview(textFieldView)
        textFieldView.frame = self.bounds
        textFieldView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.layer.cornerRadius = 30
        textField.text = title?.uppercased()
        iconView.layer.cornerRadius = 10
    }
    
    //MARK: - Actions
    
    @IBAction func iconButtonTapped(_ sender: Any) {
        textField.becomeFirstResponder()
    }
}
