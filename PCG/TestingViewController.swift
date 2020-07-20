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
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: url!) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
