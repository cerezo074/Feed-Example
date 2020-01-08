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

class PostPresenter: PostPresenterInterface {
    
    private let viewState: BehaviorRelay<PostViewState>
    private var message: String = ""
    weak var resultDelegate: PostResultDelegate?
    
    init() {
        let defaultState: PostViewState = .suggestion(message: "Come on! buddy type something ;)")
        viewState = BehaviorRelay<PostViewState>(value: defaultState)
    }
    
}

extension PostPresenter {
    
    var messageLenght: Int {
        return 250
    }
    
    var state: Driver<PostViewState> {
        return viewState.asDriver(onErrorJustReturn: .showError(message: "System not available, try later please :("))
    }
    
    func publish(from viewController: UIViewController) {
        switch viewState.value {
        case .isReady: break
        default:return
        }
        
        let randomID = Int.random(in: 1...10000)
        let result = PostResult(id: randomID, message: message)
        resultDelegate?.handle(result)
        viewState.accept(.dismiss)
    }
    
    func update(message: String) {
        if message.trimmingCharacters(in: .whitespaces).isEmpty {
            let errorState: PostViewState = .showError(message: "Empty message is not valid, post can't be created")
            viewState.accept(errorState)
            return
        }
        
        self.message = message
        let isReadyState: PostViewState = .isReady(message: "We are good to go ;)!!!")
        viewState.accept(isReadyState)
    }

}
