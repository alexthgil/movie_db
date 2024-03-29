//
//  CustomCollectionViewCell.swift
//  Cinema
//
//  Created by Alex on 9/20/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

enum CellSize {
    case defined(width: CellSizeValueType, height: CellSizeValueType)
    case calculateColumns(columnsNumber: Int)
    case undefined
}

enum CellSizeValueType {
    case equalToSuperview
    case customSizeValue(CGFloat)
}

class BasicCustomCollectionViewCell: UICollectionViewCell {
    class var itemSize: CellSize {
        return CellSize.undefined
    }
    
    class var reuseIdentifier: String {
        return ""
    }
}

protocol CollectionViewListener {
    func onWillDisplay()
    func onDidEndDisplaying()
}

protocol PlainTileRepresenter: class {
    func show(_ plainTile: PlainTileImpl)
    func uriRepresentation() -> URL?
}

class CellWithFixedColumnsNumber: CustomCollectionViewCell {
    override class var itemSize: CellSize {
        return CellSize.calculateColumns(columnsNumber: 3)
    }
}

class CustomCollectionViewCell: BasicCustomCollectionViewCell, PlainTileRepresenter, CollectionViewListener {

    override class var itemSize: CellSize {
        return CellSize.defined(width: .customSizeValue(150), height: .equalToSuperview)
    }
    
    override class var reuseIdentifier: String {
        return "CustomCollectionViewCell"
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var posterImageView: UIImageView?
    
    weak var plainTile: PlainTileImpl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5.0
    }
    
    
    func show(_ plainTile: PlainTileImpl) {
        self.plainTile = plainTile
        titleLabel?.text = plainTile.title
    }
    
    override func prepareForReuse() {
        posterImageView?.image = nil
    }
    
    func uriRepresentation() -> URL? {
        return plainTile?.uriRepresentation
    }
    
    func onWillDisplay() {
        plainTile?.loadPosterWithSize(.small) { [weak self] (img) in
            DispatchQueue.main.async {
                self?.posterImageView?.image = img
            }
        }
    }
    
    func onDidEndDisplaying() {
        posterImageView?.image = nil
        plainTile?.cancelAllNetworkTasks()
    }
    

}
