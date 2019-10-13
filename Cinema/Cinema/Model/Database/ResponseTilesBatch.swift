//
//  ResponseMD.swift
//  Cinema
//
//  Created by Alex on 2/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class ResponseTilesBatch: Codable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [AbstractDecodedTile]?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case id = "id"
    }
    
    init(page: Int?, totalResults: Int?, totalPages: Int?, results: [AbstractDecodedTile]?, id: Int?) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
        self.id = id
    }
}
