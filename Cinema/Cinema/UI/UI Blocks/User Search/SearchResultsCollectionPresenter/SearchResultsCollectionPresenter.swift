//
//  File.swift
//  Cinema
//
//  Created by Alex on 10/2/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchResultsCollectionPresenter: AtomPresenter {

    private let vc = SearchResultsCollectionViewController()
    private let collectionView: CollectionViewPresenter

    weak var delegate: CollectionViewUserActionsDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }
    
    init(model: SearchEngineModel) {
        
        _ = vc.view

        let config = UIFactory.shared.buildSearchResultsCollectionConfig(model: model)
        collectionView = CollectionViewPresenter(with: config)
        
        vc.add(collectionView.view)
    }
    
    func clearAll(completion: @escaping (() -> Void)) {
        collectionView.clearAll(completion: completion)
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return vc.view
    }
    
}
