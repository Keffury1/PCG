//
//  StateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class StateView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet var stateView: UIView!
    
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
        Bundle.main.loadNibNamed("StateView", owner: self, options: nil)
        addSubview(stateView)
        stateView.frame = self.bounds
        stateView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.addShadow()
    }

}
