//
//  StateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import DropDown

protocol StateTappedDelegate {
    func stateTapped(state: String, count: Int)
}

class StateView: UIView {
    
    //MARK: - Properties
    
    var states: [String] = []
    var showing: Bool = false
    let dropDown = DropDown()
    var template: Template?
    var count: Int?
    var stateTappedDelegate: StateTappedDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet var stateView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
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
        loadStates()
        stateView.frame = self.bounds
        stateView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.layer.cornerRadius = 30
        self.count = 0
        dropDown.anchorView = stateButton
        dropDown.backgroundColor = UIColor(named: "Navy")
        dropDown.textColor = .white
        dropDown.dataSource = states.sorted { $0 < $1 }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            stateLabel.text = item
            stateTappedDelegate?.stateTapped(state: item, count: count!)
        }
        dropDown.cornerRadius = 10
        iconView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        stateButton.layer.cornerRadius = 10
    }
    
    private func loadStates() {
        if let file = Bundle.main.url(forResource: "States", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                let states = try decoder.decode([String : String].self, from: data)
                self.states = Array(states.values)
            } catch {
                print(error)
            }
        }
    }
    
    private func toggleStates() {
        if showing {
            dropDown.hide()
            chevronButton.setBackgroundImage(UIImage(systemName: "chevron.up.circle"), for: .normal)
        } else {
            dropDown.show()
            chevronButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func iconButtonTapped(_ sender: Any) {
        toggleStates()
    }
    
    @IBAction func stateButtonTapped(_ sender: Any) {
        toggleStates()
    }
}
