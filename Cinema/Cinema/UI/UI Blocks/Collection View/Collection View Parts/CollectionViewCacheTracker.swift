//
//  CacheTracker.swift
//  Cinema
//
//  Created by Alex on 9/21/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CacheTrackerListener {
    func performBatchUpdate(batchUpdate: CollectionViewBatchUpdate)
}


class CollectionViewCacheTracker: NSObject, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            fetchedResultsController?.delegate = self
        }
    }
    
    var listener: CacheTrackerListener?
    
    init(category: Category) {

    }
    
    func performFetch() {
        try? fetchedResultsController?.performFetch()
    }
    
    func obtainTransactionBatchFromCurrentCache() {
        if let section = self.fetchedResultsController?.sections?[0], let tiles = section.objects as? [Tile] {
            let batchUpdate = CollectionViewBatchUpdate()
            for tile in tiles {
                let plainTile = PlainTileImpl(tile: tile)
                batchUpdate.add(plainTile)
            }
            listener?.performBatchUpdate(batchUpdate: batchUpdate)
        }
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    private var batchUpdate = CollectionViewBatchUpdate()
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        batchUpdate = CollectionViewBatchUpdate()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .insert, let tile = anObject as? Tile {
            let plainTile = PlainTileImpl(tile: tile)
            batchUpdate.add(plainTile)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        listener?.performBatchUpdate(batchUpdate: batchUpdate)
    }
    
}
