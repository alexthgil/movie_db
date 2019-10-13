//
//  ServerDataLoadTask.swift
//  Cinema
//
//  Created by Alex on 10/5/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class ServerBlobObjectLoadTask {
    
    private let session = DatabaseIO.shared.databaseSession
    private var dataTask: URLSessionDataTask?
    private var onDataLoadedCompletion: ((Data?) -> Void)?
    private var needCheckCache = false
    
    init() {

    }
    
    func execute() {
        if let url = dataTask?.currentRequest?.url {
            if needCheckCache {
                let cache = DatabaseIO.shared.databaseCache
                if let obj = cache.object(forKey: url as AnyObject) as? Data {
                    onDataLoadedCompletion?(obj)
                } else {
                    dataTask?.resume()
                }
            } else {
                dataTask?.resume()
            }
        }
    }
    
    func cancel() {
        dataTask?.cancel()
    }
    
    func buldLoadDataTask(url: URL, needCheckCache: Bool, completion: @escaping ((Data?) -> Void)) {
        onDataLoadedCompletion = completion
        self.needCheckCache = needCheckCache
           
        dataTask = session.dataTask(with: url, completionHandler: {[weak self](data, urlResponse, error) in
            self?.onDataLoadedCompletion?(data)
        })
    }
}
