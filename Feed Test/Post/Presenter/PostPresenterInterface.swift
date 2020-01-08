//
//  PostPresenterInterface.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 8/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias PostPresenterInterface = PostViewInteraction

enum PostViewState {
    case suggestion(message: String)
    case isReady(message: String)
    case showError(message: String)
    case dismiss
}

struct PostResult {
    let id: Int
    let message: String
}

protocol PostResultDelegate: class {
    func handle(_ result: PostResult)
}

protocol PostViewInteraction: class {
    var state: Driver<PostViewState> { get }
    var messageLenght: Int { get }
    
    func publish(from viewController: UIViewController)
    func update(message: String)
}
