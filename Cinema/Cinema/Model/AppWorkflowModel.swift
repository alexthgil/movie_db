//
//  AppWorkflow.swift
//  Cinema
//
//  Created by Alex on 9/22/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation


protocol СategoryModelBuilder: class {
    func categoryModel(for category: Category) -> CategoryModel
}

protocol AppWorkflowModel: СategoryModelBuilder {
    
}

class AppWorkflowModelImpl: AppWorkflowModel {
    
    private var categoryModel = [Category: CategoryModel]()
    
    func categoryModel(for category: Category) -> CategoryModel {
        if let m = categoryModel[category] {
            return m
        } else {
            let m = generateCategoryModel(for: category)
            categoryModel[category] = m
            return m
        }
    }
    
    //MARK: - Private
    
    func generateCategoryModel(for category: Category) -> CategoryModel {
        let m = CategoryModel(category: category)
        return m
    }
}
