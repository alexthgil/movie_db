//
//  SearchResultCollectionViewCell.swift
//  Cinema
//
//  Created by Alex on 10/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class SearchResultCollectionViewCell: BasicCustomCollectionViewCell, PlainTileRepresenter, CollectionViewListener {

    override class var itemSize: CellSize {
        return CellSize.defined(width: .equalToSuperview, height: .customSizeValue(200))
    }
    
    override class var reuseIdentifier: String {
        return "SearchResultCollectionViewCell"
    }
    
    @IBOutlet weak private var titleLabel: UILabel?
    @IBOutlet weak private var overviewLabel: UILabel?
    @IBOutlet weak private var posterImageView: UIImageView?
    
    private weak var plainTile: PlainTileImpl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func show(_ plainTile: PlainTileImpl) {
        self.plainTile = plainTile
        titleLabel?.text = plainTile.title
        overviewLabel?.text = plainTile.overview
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
    
    func uriRepresentation() -> URL? {
        return plainTile?.uriRepresentation
    }

}
