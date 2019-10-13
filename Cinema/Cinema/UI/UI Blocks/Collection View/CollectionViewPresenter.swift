//
//  CollectionViewPresenter.swift
//  Cinema
//
//  Created by Alex on 9/20/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import CoreData

protocol CollectionViewPresenterModel: class {
    func loadNextPage()
    func loadInitialData()
    func buildFetchResultsController(category: Category, completion: @escaping ((CollectionViewCacheTracker)-> Void))
    func clearAllData(category: Category, completion: @escaping (() -> Void))
}

class CollectionViewPresenterConfiguration {
    var category: Category = .none
    let model: CollectionViewPresenterModel
    var layout = UICollectionViewFlowLayout()
    var cellType = BasicCustomCollectionViewCell.self
    var dataSource: CollectionViewDataSource?
    var collectionViewDelegate: CollectionViewDelegate?
    var cellNibName: String?
    
    init(model: CollectionViewPresenterModel) {
        self.model = model
        
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
    }
    
    init(category: Category, model: CollectionViewPresenterModel) {
        self.model = model
        self.category = category
        
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
    }
}

protocol CollectionViewUserActionsDelegate: class {
    func userDidSelect(_ collectionViewPresenter: CollectionViewPresenter, objectURI: URL?)
}

class CollectionViewPresenter: AtomPresenter, CollectionViewDelegateListener {
    
    private let vc = CollectionViewController()
    private let dataSource = CollectionViewDataSource()
    private var cacheTracker: CollectionViewCacheTracker?
    private var collectionViewDelegate: CollectionViewDelegate?
    
    weak var delegate: CollectionViewUserActionsDelegate?
    
    let model: CollectionViewPresenterModel
    let category: Category
    
    init(with configuration: CollectionViewPresenterConfiguration) {
        
        _ = vc.view
        
        category = configuration.category
        
        model = configuration.model
        collectionViewDelegate = CollectionViewDelegate(listener: self)
        collectionViewDelegate?.cellSize = configuration.cellType.itemSize
        configuration.dataSource = dataSource
        configuration.dataSource?.cellType = configuration.cellType
        configuration.collectionViewDelegate = collectionViewDelegate
        
        vc.configure(with: configuration)
        vc.reloadData()
        
        model.buildFetchResultsController(category: category) { (cacheTracker) in
            DispatchQueue.main.async {
                self.cacheTracker = cacheTracker
                cacheTracker.listener = self.dataSource
                self.clearAll(completion: {
                    self.model.loadInitialData()
                })
            }
        }

    }
    
    func clearAll(completion: @escaping (() -> Void)) {
        model.clearAllData(category: category) {
            DispatchQueue.main.async {
                self.dataSource.clearAll()
                completion()
            }
        }
    }
    
    //MARK: - CollectionViewDelegateListener
    
    func willDisplayLastItemFromDataSource(_ coolectionView: UICollectionView) {
        model.loadNextPage()
    }
    
    func userDidSelect(_ coolectionView: UICollectionView, objectURI: URL?) {
        delegate?.userDidSelect(self, objectURI: objectURI)
    }
    
    //MARK: - AtomPresentor
    
    var view: UIView {
        return vc.view
    }
    
}
