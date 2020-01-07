//
//  PostPresenter.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 7/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias PostPresenterInterface = PostViewInteraction

struct PostResult {
    let id: Int
    let message: String
}

protocol PostResultDelegate: class {
    func handle(_ result: PostResult)
}

protocol PostViewInteraction {
    func generateRandomPost()
}

class PostPresenter: PostPresenterInterface {
    
    weak var resultDelegate: PostResultDelegate?
    
    init() {
        
    }
    
}

extension PostPresenter {
    
    func generateRandomPost() {
        let randomID = Int.random(in: 1...10000)
        let message = "This is a fixed message for a random post! \(randomID)"
        let result = PostResult(id: randomID, message: message)
        resultDelegate?.handle(result)
    }

}
