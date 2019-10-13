//
//  EmptyViewController.swift
//  Cinema
//
//  Created by Alex on 10/12/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {

    @IBOutlet weak var contentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func show(_ view: UIView) {
        contentView?.fill(by: view)
    }

}
