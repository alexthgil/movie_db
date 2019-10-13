//
//  CategoryViewWithTitlePresenter.swift
//  Cinema
//
//  Created by Alex on 9/29/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

struct CategoryViewWithTitleConfiguration {
    let category: Category
    let content: AtomPresenter
}

class CategoryViewWithTitlePresenter: AtomPresenter {
    
    let vc = CategoryViewWithTitleViewController()
    
    init() {
        
        _ = vc.view
        
    }
    
    var collectionViewPresenter: AtomPresenter?
    
    func configure(with configuration: CategoryViewWithTitleConfiguration) {
        vc.showTitle(configuration.category.title)
        vc.showCategoryDescription(configuration.category.subTitle)
        collectionViewPresenter = configuration.content
        vc.showCategoryContent(configuration.content)
    }
    
    //MARK: - AtomPresenter
    
    var view: UIView {
        return vc.view
    }
    
}
