//
//  ViewController.swift
//  MoviesDB
//
//  Created by Alex on 1/3/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol CategoryPresenterDelegate: CollectionViewUserActionsDelegate, CategoryViewWithTitleDelegate {
    
}

class InitialViewController: UIViewController, UserSearchControllerDelegate, UINavigationControllerDelegate, CategoryPresenterDelegate {
    
    @IBOutlet weak var contentView: UIView?
    
    private let layoutMain = LayoutStackViewPresenter()
    private let layoutContent = LayoutStackViewPresenter()
    private let searchBarViewPresenter = SearchBarViewPresenter()
    private var categoriesWithTitle = [AtomPresenter]()
    private let viewWithFixedWidth = ViewWithFixedWidthPresenter()
    private let userSearchController = UserSearchController()
    private var searchResultsCollectionPresenter: SearchResultsCollectionPresenter?
    
    private let appWorkflowModel: AppWorkflowModel = AppWorkflowModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
        
        searchBarViewPresenter.delegate = userSearchController
        searchResultsCollectionPresenter = SearchResultsCollectionPresenter(model: userSearchController.searchEngineModel)
        searchResultsCollectionPresenter?.delegate = self
        userSearchController.searchResultsCollectionPresenter = searchResultsCollectionPresenter
        
        fillCategorisWithTitle()
        let config = LayoutStackViewControllerConfiguration(vertical: true)
        layoutMain.configure(with: config)
        layoutContent.configure(with: config)
        
        userSearchController.delegate = self
        
        layoutMain.add(searchBarViewPresenter)
        
        layoutContent.add(categoriesWithTitle)
        
        layoutMain.add(layoutContent)
        
        viewWithFixedWidth.setContent(layoutMain)
        
        contentView?.fill(by: viewWithFixedWidth.view)
    }
    
    private func fillCategorisWithTitle() {
        for category in [Category.nowplaying, Category.popular, Category.toprated, Category.upcaming] {
            let presenter = UIFactory.shared.buildCategoryPresenter(for: category, modelBuilder: appWorkflowModel, actionsDelegate: self)
            categoriesWithTitle.append(presenter)
        }
    }
    
    //MARK: - UserSearchControllerListener
    
    func onUserDidStartSearch() {
        layoutMain.remove(layoutContent)
        viewWithFixedWidth.isHeightLock = true
        
        if let searchResultsCollectionPresenter = searchResultsCollectionPresenter {
            layoutMain.add(searchResultsCollectionPresenter)
        }
    }
    
    func onUserDidEndSearch() {
        viewWithFixedWidth.isHeightLock = false
        if let searchResultsCollectionPresenter = searchResultsCollectionPresenter {
            layoutMain.remove(searchResultsCollectionPresenter)
        }
        layoutMain.add(layoutContent)
    }
    
    //MARK: - CollectionViewUserActionsDelegate
    
    func userDidSelect(_ collectionViewPresenter: CollectionViewPresenter, objectURI: URL?) {
        
        guard let objectURI = objectURI else { return }

        CoreDataManager.shared.convert(uri: objectURI) { (plainItem) in
            if let plainItem = plainItem {
                DispatchQueue.main.async {[weak self] in
                    self?.showTileDetails(for: plainItem)
                }
            }
        }
    }
    
    
    //MARK: - TileDetails
    
    var detailsPresenter: TileDetailsController?

    func showTileDetails(for data: PlainTile) {
        detailsPresenter = TileDetailsController()
        if let detailsPresenter = detailsPresenter {
            detailsPresenter.show(data)
            navigationController?.pushViewController(detailsPresenter.viewController, animated: true)
        }
    }
    
    //MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if self === viewController {
            detailsPresenter = nil
        }
    }
    
    //MARK: - CategoryViewWithTitleDelegate
    
    var categoryDetails: CategoryDetailsPresenter?
    
    func onUserDidSelecCategory(sender: CategoryViewWithTitlePresenter, category: Category) {
        let m = appWorkflowModel.categoryModel(for: category)
        let c = CategoryDetailsPresenter(model: m, category: category)
        c.delegate = self
        categoryDetails = c
        
        navigationController?.pushViewController(c.viewController, animated: true)
    }

}


