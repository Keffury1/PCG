//
//  TestingViewController.swift
//  PCG
//
//  Created by Bobby Keffury on 6/4/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit
import WebKit

class TestingViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://g3d-app.com/s/app/acp3_2/en_GB/t14w79fkfnxq7px.html#p=1468069") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
