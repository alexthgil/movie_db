//
//  Model.swift
//  CinemaTest
//
//  Created by Alex on 9/14/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import CoreData

class CategoryModel: CollectionViewPresenterModel {
    
    let queue = OperationQueue()
    
    let category: Category
    var isLoading = false
    var inited: Bool = false
    
    let coreDataManager = CoreDataManager.shared
    
    init(category: Category) {
        queue.maxConcurrentOperationCount = 1
        self.category = category
    }
    
    weak var cacheTrack: CollectionViewCacheTracker?
    
    func buildFetchResultsController(category: Category, completion: @escaping ((CollectionViewCacheTracker)-> Void)) {
        queue.addOperation {
            CoreDataManager.shared.buildFetchedResultsController(category: category, entityName: "Tile", keyForSort: "itemIndex") { [weak self](controller) in
                let cacheTracker = CollectionViewCacheTracker(category: category)
                cacheTracker.fetchedResultsController = controller
                self?.cacheTrack = cacheTracker
                completion(cacheTracker)
            }
        }
    }
    
    func clearAllData(category: Category, completion: @escaping (() -> Void)) {
        queue.addOperation {[weak self] in
            self?.coreDataManager.perfomBatchDeleteRequest(category: category, entityName: "Tile", completion: {
                self?.cacheTrack?.performFetch()
                completion()
            })
        }
    }
    
    var currentRequest: URLSessionDataTask?
    func loadInitialData() {
        queue.addOperation { [weak self] in
            
            guard let strongSelf = self, strongSelf.isLoading == false, strongSelf.inited == false else {
                return
            }
            
            strongSelf.isLoading = true
            
            let databaseIO = DatabaseIO.shared
  
            strongSelf.currentRequest = databaseIO.createRequest(for: ResponseTilesBatch.self, category: strongSelf.category, page: strongSelf.page, completion: { [weak self](decodedResponse) in
                self?.saveData(decodedResponse, completion: {
                    strongSelf.isLoading = false
                    strongSelf.totalPages = decodedResponse.totalPages ?? 1
                    strongSelf.inited = true
                })
            })
            
            self?.currentRequest?.resume()
        }
    }
    
    var page = 1
    var totalPages = 1
    
    func loadNextPage() {
        queue.addOperation { [weak self] in
            
            guard let strongSelf = self else { return }
                
            let nextPage = strongSelf.page + 1

            guard strongSelf.isLoading == false, nextPage <= strongSelf.totalPages else { return }
            
            strongSelf.isLoading = true
            
            let databaseIO = DatabaseIO.shared
            
            strongSelf.currentRequest = databaseIO.createRequest(for: ResponseTilesBatch.self, category: strongSelf.category, page: nextPage, completion: { [weak self](decodedResponse) in
                self?.saveData(decodedResponse, completion: {
                    strongSelf.isLoading = false
                    strongSelf.page = strongSelf.page + 1
                })
            })
            self?.currentRequest?.resume()
        }
    }
    
    func saveData(_ decodedResponse: ResponseTilesBatch, completion: @escaping (() -> Void)) {
        queue.addOperation { [weak self] in
            
            guard let strongSelf = self else {
                completion()
                return
            }
            
            strongSelf.coreDataManager.save(for: strongSelf.category, response: decodedResponse, completion: completion)
        }
    }
}


