//
//  HomePresenter.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomePresenter {
    
    private let dataManager: HomeData
    private let disposeBag = DisposeBag()
    private let viewState = BehaviorRelay<HomeViewState>(value: .loading)
    
    init(dataManager: HomeData? = nil) {
        self.dataManager = dataManager ?? HomeDataManager()
    }
    
}

extension HomePresenter: HomePresenterInterface {
    
    var state: Driver<HomeViewState> {
        return viewState.asDriver(onErrorJustReturn: .showError(message: "System not available, try later please :("))
    }
    
    func viewDidLoad() {
        dataManager.fetchFeed()
            .subscribe(onCompleted: { [weak self] in
                self?.showFeeds()
            }) { [weak self] (error) in
                self?.showFeeds(with: error)
        }
        .disposed(by: disposeBag)
    }
    
}

private extension HomePresenter {
    
    func showFeeds(with error: Error? = nil) {
        if let error = error {
            viewState.accept(.showError(message: "System not available, try later please :("))
            print(error)
            return
        }
         
        if dataManager.feed.isEmpty {
            viewState.accept(.showError(message: "You dont have any post :("))
        } else {
            viewState.accept(.showFeed)
        }
    }
    
}
