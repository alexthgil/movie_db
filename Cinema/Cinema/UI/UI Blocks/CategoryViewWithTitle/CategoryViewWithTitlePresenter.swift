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

protocol CategoryViewWithTitleDelegate: class {
    func onUserDidSelecCategory(sender: CategoryViewWithTitlePresenter, category: Category)
}

class CategoryViewWithTitlePresenter: AtomPresenter {
    
    private let vc = CategoryViewWithTitleViewController()
    weak var delegate: CategoryViewWithTitleDelegate?
    private var category: Category = .none
    
    init() {
        
        _ = vc.view
        vc.userDidSelectCategoryActionBlock = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            self?.delegate?.onUserDidSelecCategory(sender: strongSelf, category: strongSelf.category)
        }
    }
    
    var collectionViewPresenter: AtomPresenter?
    
    func configure(with configuration: CategoryViewWithTitleConfiguration) {
        category = configuration.category
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
