//
//  UserSearchPresenter.swift
//  Cinema
//
//  Created by Alex on 10/2/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol UserSearchControllerDelegate: class {
    func onUserDidStartSearch()
    func onUserDidEndSearch()
}

class UserSearchController: SearchViewPresenterListener {

    let searchEngineModel: SearchEngineModel = SearchEngineModelImpl()
    weak var searchResultsCollectionPresenter: SearchResultsCollectionPresenter?
    weak var delegate: UserSearchControllerDelegate?
    
    init() {
        
    }

    //MARK: - SearchViewPresenterListener
    
    func onTextDidChange(_ presenter: SearchBarViewPresenter, searchText: String) {
        if searchText == "" {
            
            searchResultsCollectionPresenter?.clearAll(completion: {
                
            })
            
        } else {
            searchResultsCollectionPresenter?.clearAll(completion: {[weak self] in
                self?.searchEngineModel.loadInitialData(for: searchText)
                self?.delegate?.onUserDidStartSearch()
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ presenter: SearchBarViewPresenter) {
        delegate?.onUserDidEndSearch()
    }
    
}
