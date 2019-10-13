//
//  BatchUpdate.swift
//  Cinema
//
//  Created by Alex on 9/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class CollectionViewBatchUpdate {
    
    var newTiles = [PlainTileImpl]()
    
    func add(_ tile: PlainTileImpl) {
        newTiles.append(tile)
    }
}
