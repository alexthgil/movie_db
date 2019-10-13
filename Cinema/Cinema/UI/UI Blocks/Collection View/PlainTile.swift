//
//  CollectionViewCacheTracker.swift
//  Cinema
//
//  Created by Alex on 10/6/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol PlainTile: class {
    var voteAverage: Double? { get }
    var voteCount: Int? { get }
    var id: Int? { get }
    var video: Bool? { get }
    var title: String? { get }
    var popularity: Double? { get }
    var adult: Bool? { get }
    var overview: String? { get }
    var releaseDate: String? { get }
    var posterPath: String? { get }
    var itemIndex: Int? { get }
    var sectionIndex: Int? { get }
    var category: Int? { get }
    
    func loadPosterWithSize(_ posterSize: PosterSize, completionHandler:((UIImage?) -> Void)?)
    func cancelAllNetworkTasks()
}


class PlainTileImpl: PlainTile {
    
    var voteAverage: Double?
    var voteCount: Int?
    var id: Int?
    var video: Bool?
    var title: String?
    var popularity: Double?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var posterPath: String?
    var itemIndex: Int?
    var sectionIndex: Int?
    var category: Int?
    
    let uriRepresentation: URL

    
    init(tile: Tile) {
        self.voteAverage = tile.voteAverage
        self.voteCount = tile.voteCount
        self.id = tile.id
        self.video = tile.video
        self.title = tile.title
        self.popularity = tile.popularity
        self.adult = tile.adult
        self.overview = tile.overview
        self.releaseDate = tile.releaseDate
        self.posterPath = tile.posterPath
        
        self.uriRepresentation = tile.objectID.uriRepresentation()
    }
    
    private var loadPosterDataTask: URLSessionDataTask?
    
    private let serverDataLoadTask = ServerBlobObjectLoadTask()

    func loadPosterWithSize(_ posterSize: PosterSize, completionHandler: ((UIImage?) -> Void)?) {
        
        guard
            let posterPath = posterPath,
            let url = DatabaseIO.shared.buildPosterURL(size: posterSize, posterPath: posterPath)
        else {
            completionHandler?(nil)
            return
        }
        
        serverDataLoadTask.buldLoadDataTask(url: url, needCheckCache: true) { (imgData) in
            if let imgData = imgData, let img = UIImage(data: imgData) {
                completionHandler?(img)
            }
        }
        serverDataLoadTask.execute()
    }
        
    func cancelAllNetworkTasks() {
        serverDataLoadTask.cancel()
    }
}
