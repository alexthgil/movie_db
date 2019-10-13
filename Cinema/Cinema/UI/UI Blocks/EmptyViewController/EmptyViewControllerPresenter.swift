//
//  EmptyViewControllerPresenter.swift
//  Cinema
//
//  Created by Alex on 10/13/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit


class EmptyViewControllerPresenter: AtomPresenter {
    
    private let vc = EmptyViewController()
    
    init() {
        
        _ = vc.view
        
    }
    
    func show(_ presenter: AtomPresenter) {
        vc.show(presenter.view)
    }
    
    var viewController: UIViewController {
        return vc
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return vc.view
    }
    
}
