//
//  CategoryDetails.swift
//  Cinema
//
//  Created by Alex on 10/24/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol CategoryDetailsPresenterDelegate: class {
    func userDidSelect(objectWithURI uri: URL?)
}

class CategoryDetailsPresenter: AtomPresenter, CollectionViewUserActionsDelegate {

    private let collectionViewPresenter: CollectionViewPresenter
    private let emptyViewController = EmptyViewControllerPresenter()
    
    weak var delegate: CollectionViewUserActionsDelegate?
    
    init(model: CollectionViewPresenterModel, category: Category) {
        
        let config = UIFactory.shared.buildCategoryDetailsConfig(withCategoryType: category, model: model)
        collectionViewPresenter = CollectionViewPresenter(with: config)
        collectionViewPresenter.delegate = self
        emptyViewController.show(collectionViewPresenter)
    }
    
    //MARK: AtomPresenter
    
    var view: UIView {
        return emptyViewController.view
    }
    
    var viewController: UIViewController {
        return emptyViewController.viewController
    }
    
    //MARK: - CollectionViewUserActionsDelegate
    
    func userDidSelect(_ collectionViewPresenter: CollectionViewPresenter, objectURI: URL?) {
        if self.collectionViewPresenter === collectionViewPresenter {
            delegate?.userDidSelect(collectionViewPresenter, objectURI: objectURI)
        }
    }
}
