//
//  CategoryViewWithTitleViewController.swift
//  Cinema
//
//  Created by Alex on 9/29/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class CategoryViewWithTitleViewController: UIViewController {

    @IBOutlet private weak var categoryTitleLabel: UILabel?
    @IBOutlet private weak var categorySubTitleLabel: UILabel?
    @IBOutlet private weak var contentView: UIView?
    @IBOutlet private weak var categoryButton: UIButton?
    
    var userDidSelectCategoryActionBlock: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showTitle(_ title: String) {
        categoryTitleLabel?.text = title
        categoryButton?.setTitle(title, for: .normal)
    }
    
    func showCategoryDescription(_ description: String) {
        categorySubTitleLabel?.text = description
    }
    
    func showCategoryContent(_ content: AtomPresenter) {
        contentView?.fill(by: content.view)
    }
    
    @IBAction func userDidSelectCategory(_ sender: UIButton) {
        userDidSelectCategoryActionBlock?()
    }
}
