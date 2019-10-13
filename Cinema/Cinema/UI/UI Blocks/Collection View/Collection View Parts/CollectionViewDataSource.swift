//
//  DataSource.swift
//  Cinema
//
//  Created by Alex on 9/21/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject, CacheTrackerListener, UICollectionViewDataSource {    

    private var numberOfItems = 0
    private var numberOfSections = 1
    private var plainTiles = [PlainTileImpl]()
    
    var cellType = BasicCustomCollectionViewCell.self
    
    private weak var collectionView: UICollectionView?
    
    override init() {
        numberOfItems = 100
    }
    
    func configureWith(collectionView: UICollectionView) {
        self.collectionView = collectionView
        collectionView.dataSource = self
    }
    
    func performBatchUpdate(batchUpdate: CollectionViewBatchUpdate) {

        DispatchQueue.main.async {
            guard let collectionView = self.collectionView else {
                 return
            }

            collectionView.performBatchUpdates({
                let lastIndex = self.numberOfItems
                self.numberOfItems += batchUpdate.newTiles.count
                self.plainTiles.append(contentsOf: batchUpdate.newTiles)

                for tileIndex in lastIndex..<self.numberOfItems {
                    collectionView.insertItems(at: [IndexPath(item: tileIndex, section: 0)])
                }

            })
        }
    }
    
    func clearAll() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.performBatchUpdates({
            self.numberOfItems = 0
            self.numberOfSections = 0
            collectionView.deleteSections(IndexSet(integer: 0))
            self.numberOfSections = 1
            collectionView.insertSections(IndexSet(integer: 0))
            plainTiles = []
        })
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reuseIdentifier = cellType.reuseIdentifier
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? (PlainTileRepresenter & UICollectionViewCell) {
            if 0 <= indexPath.item && indexPath.item < plainTiles.count {
                let plainTile = plainTiles[indexPath.item]
                cell.show(plainTile)
            }
            return cell
        }
        
        return UICollectionViewCell()

    }
}
