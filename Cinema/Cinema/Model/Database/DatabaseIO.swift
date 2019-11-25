//
//  DatabaseIO.swift
//  Cinema
//
//  Created by Alex on 2/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import CoreData

enum PosterSize {
    case small
    case large
    
    func poseterURLPrefix() -> String {
        switch self {
        case .large:
            return "w500"
        case .small:
            return "w200"
        }
    }
    
}

class DatabaseIO {
    
    static let shared = DatabaseIO()
    
    let databaseCache = NSCache<AnyObject, AnyObject>()
    let databaseSession: URLSession

    private let API_KEY = ""
    
    private init(){
        databaseCache.countLimit = 40
        let databaseSessionConfig = URLSessionConfiguration.default
        self.databaseSession = URLSession(configuration: databaseSessionConfig)
    }
    
    //MARK: - Private Methods
    
    private func buildUrlComponents(for category: Category, page: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = category.path
        let apiKeyComponent = URLQueryItem(name: "api_key", value: self.API_KEY)
        let languageComponent = URLQueryItem(name: "language", value: "en-US")
        let pageComponent = URLQueryItem(name: "page", value: "\(page)")
        components.queryItems = [apiKeyComponent, languageComponent, pageComponent]
        return components
    }
    
    func buildUrlComponentsForRelatedVideos(for id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/\(id)/videos"
        let apiKeyComponent = URLQueryItem(name: "api_key", value: self.API_KEY)
        let languageComponent = URLQueryItem(name: "language", value: "en-US")
        components.queryItems = [apiKeyComponent, languageComponent]
        return components
    }
    
    private func buildUrlComponents(forUserSearch searchString: String, page: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/multi"
        let apiKey = URLQueryItem(name: "api_key", value: self.API_KEY)
        let language = URLQueryItem(name: "language", value: "en-US")
        let query = URLQueryItem(name: "query", value: searchString)
        let page = URLQueryItem(name: "page", value: "\(page)")
        let includeAdult = URLQueryItem(name: "include_adult", value: "false")
        components.queryItems = [apiKey, language, query, page, includeAdult]
        return components
    }
    
    func buildPosterURL(size: PosterSize, posterPath: String) -> URL? {
        let posterSizePrefix = size.poseterURLPrefix()
        let urlStr : String = "https://image.tmdb.org/t/p/\(posterSizePrefix)"+posterPath
        return URL(string: urlStr)
    }
    
    func createRequest<T: Decodable>(for typeClass: T.Type, category: Category, page: Int, completion:@escaping ((_ data: T) -> Void)) -> URLSessionDataTask? {
        let urlComponents = buildUrlComponents(for: category, page: page)
        return executableRequest(with: typeClass, urlComponents: urlComponents, completion: completion)
    }
    
    func createRequest<T: Decodable>(forUserSearch searchString: String, typeClass: T.Type, page: Int, completion:@escaping ((_ data: T)->Void)) -> URLSessionDataTask? {
        let urlComponents = buildUrlComponents(forUserSearch: searchString, page: page)
        return executableRequest(with: typeClass, urlComponents: urlComponents, completion: completion)
    }
    
    func executableRequest<T: Decodable>(with typeClass: T.Type, urlComponents: URLComponents, completion:@escaping ((_ data: T)->Void)) -> URLSessionDataTask? {
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        let sessionDataTask = databaseSession.dataTask(with: url, completionHandler: { (objectsData, response, error) in
            let dataDecoder = DataDecoder()
            guard
                let objectsData = objectsData,
                let decodedResponse = dataDecoder.decode(typeClass: T.self, data: objectsData)
                else {
                    return
            }
            
            completion(decodedResponse)
        })
        return sessionDataTask
        
    }
}
