//
//  SearchEngine.swift
//  Cinema
//
//  Created by Alex on 10/2/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol SearchEngineModel: CollectionViewPresenterModel {
    func loadInitialData(for searchString: String)
}

class SearchEngineModelImpl: CategoryModel, SearchEngineModel {
    
    init() {
        super.init(category: .none)
    }
    
    override func buildFetchResultsController(category: Category, completion: @escaping ((CollectionViewCacheTracker)-> Void)) {
        queue.addOperation {[weak self] in
            CoreDataManager.shared.buildFetchedResultsController(category: category, entityName: "Tile", keyForSort: "title") {(controller) in
                let cacheTracker = CollectionViewCacheTracker(category: category)
                cacheTracker.fetchedResultsController = controller
                self?.cacheTrack = cacheTracker
                completion(cacheTracker)
            }
        }
    }
    
    private var searchString = ""
    
    func loadInitialData(for searchString: String) {
        queue.addOperation { [weak self] in
            
            guard let strongSelf = self, strongSelf.isLoading == false else {
                return
            }
            
            strongSelf.isLoading = true
            
            strongSelf.searchString = searchString
            
            let databaseIO = DatabaseIO.shared
            
            self?.currentRequest = databaseIO.createRequest(forUserSearch: strongSelf.searchString, typeClass: ResponseTilesBatch.self, page: strongSelf.page) { (decodedResponse) in
                self?.saveData(decodedResponse, completion: {
                    strongSelf.isLoading = false
                    strongSelf.totalPages = decodedResponse.totalPages ?? 1
                })
            }
            
            self?.currentRequest?.resume()
        }
    }
        
    override func loadNextPage() {
        queue.addOperation { [weak self] in
            
            guard let strongSelf = self else { return }
            
            let nextPage = strongSelf.page + 1
            
            guard strongSelf.isLoading == false, nextPage <= strongSelf.totalPages else { return }
            
            strongSelf.isLoading = true
            
            let database = DatabaseIO.shared
            
            self?.currentRequest = database.createRequest(forUserSearch: strongSelf.searchString, typeClass: ResponseTilesBatch.self, page: strongSelf.page) { (decodedResponse) in
                self?.saveData(decodedResponse, completion: {
                    strongSelf.isLoading = false
                    strongSelf.page = strongSelf.page + 1
                })
            }
            
            self?.currentRequest?.resume()
        }
    }
    
    override func loadInitialData() {
        
    }
}
