//
//  StartLayoutViewController.swift
//  Cinema
//
//  Created by Alex on 9/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

struct LayoutStackViewControllerConfiguration {
    let vertical: Bool
}

class LayoutStackViewViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func add(_ viewArray: [AtomPresenter]) {
        for index in 0..<viewArray.count {
            let content = viewArray[index]
            stackView?.addArrangedSubview(content.view)
        }
    }
    
    func remove(_ view: AtomPresenter) {
        view.view.removeFromSuperview()
    }
    
    func configure(with config: LayoutStackViewControllerConfiguration) {
        stackView?.axis = config.vertical ? NSLayoutConstraint.Axis.vertical : NSLayoutConstraint.Axis.horizontal
    }
}
