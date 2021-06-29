//
//  DateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class DateView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet var dateView: UIView!
    
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
        Bundle.main.loadNibNamed("DateView", owner: self, options: nil)
        addSubview(dateView)
        dateView.frame = self.bounds
        dateView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.addShadow()
    }

}
