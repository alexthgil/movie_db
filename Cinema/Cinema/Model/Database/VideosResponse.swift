//
//  VideosResponse.swift
//  Cinema
//
//  Created by Alex on 10/13/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class VideosResponse: Codable {
    let id: Int
    let results: [VideosResponseResult]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }

    init(id: Int, results: [VideosResponseResult]) {
        self.id = id
        self.results = results
    }
}

// MARK: - Result
class VideosResponseResult: Codable {
    let id: String
    let iso639_1: String
    let iso3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }

    init(id: String, iso639_1: String, iso3166_1: String, key: String, name: String, site: String, size: Int, type: String) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}
