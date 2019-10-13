//
//  SearchResultsCollectionViewController.swift
//  Cinema
//
//  Created by Alex on 10/2/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchResultsCollectionViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func add(_ view: UIView) {
        contentView?.fill(by: view)
    }
    
}
