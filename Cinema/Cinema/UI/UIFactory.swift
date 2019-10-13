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
    
}
