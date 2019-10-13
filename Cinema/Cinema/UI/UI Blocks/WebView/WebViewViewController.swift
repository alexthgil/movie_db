//
//  WebViewViewController.swift
//  Cinema
//
//  Created by Alex on 10/12/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func show(_ id: String) {
        if let url = URL(string: "https://www.youtube.com/embed/\(id)") {
            let urlRequest = URLRequest(url: url)
            webView?.loadRequest(urlRequest)
        }
    }
}
