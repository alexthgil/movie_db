//
//  ScrollViewWithFixedWidthPresenter.swift
//  Cinema
//
//  Created by Alex on 9/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ViewWithFixedWidthPresenter: AtomPresenter {
    
    private let vc = ViewWithFixedWidthViewContoller()
    
    init() {
        
        _ = vc.view

        vc.isWidthLock = true
    }
    
    var viewController: UIViewController {
        return vc
    }
    
    func setContent(_ content: AtomPresenter) {
        vc.setContent(content)
    }
    
    var isWidthLock: Bool {
        set {
            vc.isWidthLock = newValue
        }
        
        get {
            return vc.isWidthLock
        }
    }
    
    var isHeightLock: Bool {
        set {
            vc.isHeightLock = newValue
        }
        
        get {
            return vc.isHeightLock
        }
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return vc.view
    }
    
}
