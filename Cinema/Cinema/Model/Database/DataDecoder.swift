//
//  DataDecoder.swift
//  Cinema
//
//  Created by Alex on 10/6/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

class DataDecoder {
    
    func decode<T: Decodable>(typeClass: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        if let decodedResponse = try? decoder.decode(T.self, from: data) {
            return decodedResponse
        }
        
        return nil
    }
}
