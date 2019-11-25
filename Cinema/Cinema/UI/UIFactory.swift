//
//  UIFactory.swift
//  Cinema
//
//  Created by Alex on 10/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit


class UIFactory {
    static let shared = UIFactory()
    
    func buildSearchResultsCollectionConfig(model: CollectionViewPresenterModel) -> CollectionViewPresenterConfiguration {
        let cellType = SearchResultCollectionViewCell.self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        let config = CollectionViewPresenterConfiguration(model: model)
        config.cellType = cellType
        config.layout = layout
        return config
    }
    
    func buildCategoryConfig(withCategoryType category: Category, model: CollectionViewPresenterModel) -> CollectionViewPresenterConfiguration {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let config = CollectionViewPresenterConfiguration(category: category, model: model)
        config.cellType = CustomCollectionViewCell.self
        config.layout = layout
        return config
    }
    
    func buildCategoryDetailsConfig(withCategoryType category: Category, model: CollectionViewPresenterModel) -> CollectionViewPresenterConfiguration {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.minimumInteritemSpacing = 5
        let config = CollectionViewPresenterConfiguration(category: category, model: model)
        config.cellType = CellWithFixedColumnsNumber.self
        config.layout = layout
        return config
    }
    
    func buildCategoryPresenter(for category: Category, modelBuilder: СategoryModelBuilder, actionsDelegate: CategoryPresenterDelegate) -> CategoryViewWithTitlePresenter {
        
        let model = modelBuilder.categoryModel(for: category)
        let config = UIFactory.shared.buildCategoryConfig(withCategoryType: category, model: model)
        
        let collectionViewPresenter = CollectionViewPresenter(with: config)
        collectionViewPresenter.delegate = actionsDelegate
        let categoryWithTitleConfig = CategoryViewWithTitleConfiguration(category: category, content: collectionViewPresenter)
        
        let categoryViewWithTitlePresenter = CategoryViewWithTitlePresenter()
        categoryViewWithTitlePresenter.delegate = actionsDelegate
        categoryViewWithTitlePresenter.configure(with: categoryWithTitleConfig)
        return categoryViewWithTitlePresenter
    }
    
}
