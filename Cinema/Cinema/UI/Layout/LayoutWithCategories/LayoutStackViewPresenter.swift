//
//  File.swift
//  Cinema
//
//  Created by Alex on 9/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit


class LayoutStackViewPresenter: AtomPresenter {
    
    let vc = LayoutStackViewViewController()
    
    init() {
        
        _ = vc.view
        
    }
    
    func add(_ viewArray: [AtomPresenter]) {
        vc.add(viewArray)
    }
    
    func add(_ view: AtomPresenter) {
        vc.add([view])
    }
    
    func remove(_ view: AtomPresenter) {
        vc.remove(view)
    }
    
    func configure(with config: LayoutStackViewControllerConfiguration) {
        vc.configure(with: config)
    }
    
    //MARK: - AtomPresentor
    
    var view: UIView {
        return vc.view
    }
}
