//
//  TextFieldView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet var textFieldView: UIView!
    
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
        
        self.addShadow()
    }
}
