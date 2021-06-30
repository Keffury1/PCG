//
//  DateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import FSCalendar

class DateView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet var dateView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var chevronButton: UIButton!
    @IBOutlet weak var calendarView: FSCalendar!
    
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
        self.layer.cornerRadius = 30
    }
    
    private func toggleCalendar() {
        if calendarView.isHidden {
            calendarView.isHidden = false
            dividerView.isHidden = false
        } else {
            calendarView.isHidden = true
            dividerView.isHidden = true
        }
    }
    
    //MARK: - Actions
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        toggleCalendar()
    }
    
    @IBAction func iconButtonTapped(_ sender: Any) {
        toggleCalendar()
    }
}
