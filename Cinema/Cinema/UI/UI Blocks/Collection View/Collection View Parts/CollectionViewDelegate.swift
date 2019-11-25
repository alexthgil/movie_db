//
//  CollectionViewDelegate.swift
//  Cinema
//
//  Created by Alex on 9/27/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol CollectionViewDelegateListener: class {
    func willDisplayLastItemFromDataSource(_ coolectionView: UICollectionView)
    func userDidSelect(_ coolectionView: UICollectionView, objectURI: URL?)
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var cellSize: CellSize = CellSize.undefined
        
    weak var listener: CollectionViewDelegateListener?
    
    init(listener: CollectionViewDelegateListener) {
        self.listener = listener
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        if
            0 <= sectionIndex && sectionIndex < collectionView.numberOfSections &&
            0 <= itemIndex && itemIndex < collectionView.numberOfItems(inSection: sectionIndex)
        {
            
            if let cell = cell as? CollectionViewListener {
                cell.onWillDisplay()
            }
            
            if itemIndex == collectionView.numberOfItems(inSection: sectionIndex) - 2 {
                listener?.willDisplayLastItemFromDataSource(collectionView)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        if
            0 <= sectionIndex && sectionIndex < collectionView.numberOfSections &&
            0 <= itemIndex && itemIndex < collectionView.numberOfItems(inSection: sectionIndex)
        {
            
            if let cell = cell as? CollectionViewListener {
                cell.onDidEndDisplaying()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0
        var height: CGFloat = 0

        
        switch cellSize {
        case .undefined:
            break
        case .defined(width: let w, height: let h):
            switch w {
            case .equalToSuperview:
                width = collectionView.bounds.size.width
            case .customSizeValue(let sw):
                width = sw
            }
            
            switch h {
            case .equalToSuperview:
                height = collectionView.bounds.size.height
            case .customSizeValue(let sh):
                height = sh
            }

        case .calculateColumns(columnsNumber: let number):
            width = ceil(collectionView.bounds.size.width / CGFloat(number))
            height = ceil(width * 4.0 / 3.0)
        }
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            width = width - 2 * layout.minimumInteritemSpacing
            height = height - 2 * layout.minimumLineSpacing
        } else {
            width = width - 10
            height = height - 10
        }
        
        let size = CGSize(width: width, height: height)
        return size
    }
    
    //MARK: - CollectionViewUserActionsListener
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        if
            0 <= sectionIndex && sectionIndex < collectionView.numberOfSections &&
                0 <= itemIndex && itemIndex < collectionView.numberOfItems(inSection: sectionIndex),
            let cell = collectionView.cellForItem(at: indexPath) as? PlainTileRepresenter
        {
            let uri = cell.uriRepresentation()
            listener?.userDidSelect(collectionView, objectURI: uri)
        }
    }
    
}
