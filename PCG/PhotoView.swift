//
//  PhotoView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet var photoView: UIView!
    
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
        Bundle.main.loadNibNamed("PhotoView", owner: self, options: nil)
        addSubview(photoView)
        photoView.frame = self.bounds
        photoView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.addShadow()
    }

}
