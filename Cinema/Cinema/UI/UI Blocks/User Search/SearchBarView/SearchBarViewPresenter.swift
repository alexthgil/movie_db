//
//  SearchViewPresenter.swift
//  Cinema
//
//  Created by Alex on 9/29/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol SearchViewPresenterListener: class {
    func onTextDidChange(_ presenter: SearchBarViewPresenter, searchText: String)
    func searchBarCancelButtonClicked(_ presenter: SearchBarViewPresenter)
}

class SearchBarViewPresenter: NSObject, UISearchBarDelegate, AtomPresenter, SearchBarViewControllerListener {

    let vc = SearchBarViewController()
    weak var delegate: SearchViewPresenterListener?
    
    override init() {
        super.init()
        
        _ = vc.view
        
        vc.delegate = self
    }
    
    //MARK: - AtomPresentor
    
    var view: UIView {
        return vc.view
    }
    
    //MARK: - SearchViewControllerListener
    
    func onTextDidChange(_ vc: SearchBarViewController, searchText: String) {
        delegate?.onTextDidChange(self, searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ vc: SearchBarViewController) {
        delegate?.searchBarCancelButtonClicked(self)
    }
    
}
