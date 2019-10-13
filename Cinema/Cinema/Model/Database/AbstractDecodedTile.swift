//
//  AbstractDecodedTile.swift
//  Cinema
//
//  Created by Alex on 7/25/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class AbstractDecodedTile: Codable {
    
    var voteAverage: Double
    var voteCount: Int
    var id: Int
    var video: Bool
    var title: String?
    var popularity: Double
    var adult: Bool
    var overview: String?
    var releaseDate: String?
    var posterPath: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.overview =  try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        self.releaseDate =  try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        self.voteCount =  try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.adult = false
        self.video = true
    }
    
    public func encode(to encoder: Encoder) throws { }
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case mediaType = "media_type"
        case title = "title"
        case popularity = "popularity"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
