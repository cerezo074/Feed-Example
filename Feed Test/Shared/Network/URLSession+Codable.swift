//
//  URLSession+Codable.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

extension URLSession {
    
    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completionHandler(object, response, nil)
            } catch {
                completionHandler(nil, response, error)
            }
        }
    }
    
}
