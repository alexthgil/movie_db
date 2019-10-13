//
//  TileDetailsController.swift
//  Cinema
//
//  Created by Alex on 10/13/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit


class TileDetailsController: AtomPresenter {

    private let tileDetailsPresenter = TileDetailsPresenter()
    private let viewWithFixedWidth = ViewWithFixedWidthPresenter()
    private let emptyViewControllerPresenter = EmptyViewControllerPresenter()
    
    init() {
        
        tileDetailsPresenter.set(parentView: emptyViewControllerPresenter.view)
        
        viewWithFixedWidth.setContent(tileDetailsPresenter)
        emptyViewControllerPresenter.show(viewWithFixedWidth)
    }
    
    func show(_ data: PlainTile) {
        tileDetailsPresenter.show(data)
    }
    
    var viewController: UIViewController {
        return emptyViewControllerPresenter.viewController
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return emptyViewControllerPresenter.view
    }
}
