//
//  StateView.swift
//  PCG
//
//  Created by Bobby Keffury on 6/28/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import UIKit
import DropDown

class StateView: UIView {
    
    //MARK: - Properties
    
    var states: [String] = []
    var showing: Bool = false
    let dropDown = DropDown()
    
    //MARK: - Outlets
    
    @IBOutlet var stateView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    @IBOutlet weak var stateButton: UIButton!
    
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
        
        self.addShadow()
        self.layer.cornerRadius = 30
        dropDown.anchorView = stateButton
        dropDown.backgroundColor = .clear
        dropDown.textColor = .white
        dropDown.dataSource = states
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            stateLabel.text = item
        }
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
        } else {
            dropDown.show()
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
