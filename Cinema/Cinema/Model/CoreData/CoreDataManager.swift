//
//  CoreDataManager.swift
//  MoviesDB
//
//  Created by Alex on 1/4/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    private let persistentContainerName = "Cinema"
    private var persistentContainer: NSPersistentContainer?
    private var managedObjectContext: NSManagedObjectContext?

    private let queue = OperationQueue()
    
    init() {

        queue.maxConcurrentOperationCount = 1
        
        queue.addOperation {
            let pContainer = NSPersistentContainer(name: self.persistentContainerName)
            self.managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            self.managedObjectContext?.automaticallyMergesChangesFromParent = true
            pContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                } else {
                    self.persistentContainer = pContainer
                    self.managedObjectContext?.persistentStoreCoordinator = pContainer.persistentStoreCoordinator
                }
            })
        }
    }

    func buildFetchedResultsController(category: Category, entityName: String, keyForSort: String, completion: @escaping ((NSFetchedResultsController<NSFetchRequestResult>?) -> Void)) {
        queue.addOperation {[weak self] in
            
            guard let strongSelf = self else { return }
            
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = strongSelf.managedObjectContext
            context.automaticallyMergesChangesFromParent = true
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.fetchBatchSize = 20
            let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
            fetchRequest.predicate = NSPredicate(format: "category == \(category.rawValue)")
            fetchRequest.sortDescriptors = [sortDescriptor]
            let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try? fetchedResultsController.performFetch()
            completion(fetchedResultsController)
        }
    }
    
    func save(for category: Category, response: ResponseTilesBatch, completion: @escaping (() -> Void)) {
        
        queue.addOperation {[weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            self?.managedObjectContext?.performAndWait {
            
                if let decodedObjects = response.results, let page = response.page, let context = strongSelf.managedObjectContext {
                    for (index, decodedObject) in decodedObjects.enumerated() {
                        let tile = Tile(context: context)
                        tile.posterPath = decodedObject.posterPath
                        tile.title = decodedObject.title
                        tile.overview =  decodedObject.overview
                        tile.releaseDate =  decodedObject.releaseDate
                        tile.voteCount =  decodedObject.voteCount
                        tile.voteAverage = decodedObject.voteAverage
                        tile.popularity = decodedObject.popularity
                        tile.id = decodedObject.id
                        tile.sectionIndex = page
                        tile.itemIndex = index
                        tile.category = category.rawValue
                    }
                }
                try? strongSelf.managedObjectContext?.save()
                try? strongSelf.managedObjectContext?.parent?.save()
                completion()
            }
        }
    }
    
    func perfomBatchDeleteRequest(category: Category, entityName: String, completion: @escaping (()->Void)) {
        
        queue.addOperation {[weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.managedObjectContext?.performAndWait {
                do {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    request.predicate = NSPredicate(format: "category == \(category.rawValue)")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                    try strongSelf.managedObjectContext?.execute(deleteRequest)
                } catch {
                    
                }
                try? strongSelf.managedObjectContext?.save()
                completion()
            }
        }
    }
    
    func buildContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.automaticallyMergesChangesFromParent = true
        context.parent = managedObjectContext
        return context
    }
    
    func convert(uri: URL, completion: @escaping ((PlainTile?) -> Void)) {
        
        queue.addOperation {[weak self] in

            guard let strongSelf = self else { return }

            strongSelf.managedObjectContext?.performAndWait {

                var plainTile: PlainTile? = nil

                if
                    let objectID = strongSelf.managedObjectContext?.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri),
                    let tile = strongSelf.managedObjectContext?.object(with: objectID) as? Tile
                {
                    plainTile = PlainTileImpl(tile: tile)
                }
                completion(plainTile)
            }
        }
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        if let context = persistentContainer?.viewContext, context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
