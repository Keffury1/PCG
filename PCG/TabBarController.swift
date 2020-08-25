//
//  TabBarController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = true
        self.tabBar.backgroundColor = .white
        self.selectedIndex = 2
    }
}
