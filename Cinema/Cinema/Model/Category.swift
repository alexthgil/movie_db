//
//  Category.swift
//  Cinema
//
//  Created by Alex on 10/13/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

enum Category: Int, CaseIterable {
    case none = 0
    case upcaming = 1
    case toprated = 2
    case nowplaying = 3
    case popular = 4
    
    func sortDescriptor() -> String {
        switch self {
        case .none:
            return ""
        case .upcaming:
            return "upcaming"
        case .toprated:
            return "toprated"
        case .nowplaying:
            return "nowplaying"
        case .popular:
            return "popular"
        }
    }
    
    var title: String {
        switch self {
        case .none:
            return ""
        case .nowplaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .toprated:
            return "Top Rated"
        case .upcaming:
            return "Upcoming"
        }
    }
    
    var subTitle: String {
        switch self {
        case .none:
            return ""
        case .nowplaying:
            return "latest movies now playing in theatres"
        case .popular:
            return "current popular movies on TMDb"
        case .toprated:
            return "top rated movies on TMDb"
        case .upcaming:
            return "upcoming movies in theatres"
        }
    }
    
    var path: String {
        switch self {
        case .none:
            return ""
        case .nowplaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .toprated:
            return "/3/movie/top_rated"
        case .upcaming:
            return "/3/movie/upcoming"
        }
    }
}
