//
//  TileDetailsPresenter.swift
//  Cinema
//
//  Created by Alex on 10/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class TileDetailsPresenter: AtomPresenter {
    
    private let vc = TileDetailsViewController()
    
    init() {

        _ = vc.view

    }
    
    func set(parentView: UIView ) {
        vc.setParentView(view)
    }
    
    func show(_ data: PlainTile) {
        vc.show(data)
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return vc.view
    }
    
}
