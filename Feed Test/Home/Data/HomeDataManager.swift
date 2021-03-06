//
//  HomeDataManager.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeData: class {
    var feed: Feed { get }
    
    func fetchFeed() -> Completable
    @discardableResult func insertFeed(from result: PostResult) -> FeedElement
}

class HomeDataManager {
    
    private(set) var feed: Feed = []
    private let urlSession: URLSession
    
    init(urlSession: URLSession? = nil) {
        self.urlSession = urlSession ?? URLSession(configuration: .default)
    }
    
}

extension HomeDataManager: HomeData {
    
    func fetchFeed() -> Completable {
        return Completable.create { [weak self] completabe in
            guard let feedURL = HomeServiceDefinitions.feedURL else {
                completabe(.error(URLSession.HomeFeedError.invalidURL))
                return Disposables.create()
            }
            
            let dataTask = self?.urlSession.feedTask(with: feedURL) { (feed, response, error) in
                if let feed = feed {
                    self?.feed = feed
                    completabe(.completed)
                }
                
                if let requestError = error {
                    completabe(.error(requestError))
                }
            }
            
            dataTask?.resume()
            
            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
    
    @discardableResult func insertFeed(from result: PostResult) -> FeedElement {
        let newModel = FeedElement(id: result.id,
                                   firstName: "Example firstName",
                                   lastName: "Example lastName",
                                   postBody: result.message,
                                   unixTimestamp: "Example unixTimestamp",
                                   image: nil,
                                   localImage: result.image)
        
        feed.insert(newModel, at: 0)
        
        return newModel
    }
    
}

fileprivate extension URLSession {
    
    enum HomeFeedError: Error {
        case invalidURL
    }
    
    func feedTask(with url: URL, completionHandler: @escaping (Feed?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
         return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
}
