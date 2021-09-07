//
//  DateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import FSCalendar

protocol DateDelegate {
    func dateTapped(date: String)
}

class DateView: UIView {
    
    //MARK: - Properties
    
    var dateDelegate: DateDelegate?
    var id: Int?
    
    //MARK: - Outlets
    
    @IBOutlet var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        iconView.layer.cornerRadius = 10
        calendarView.layer.cornerRadius = 10
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = dateFormatter.string(from: datePicker.date)
        dateLabel.text = date
        dateDelegate?.dateTapped(date: date)
    }
}
