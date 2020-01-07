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
import IGListKit

class HomePresenter: HomePresenterInterface {
    
    private let dataManager: HomeData
    private let disposeBag = DisposeBag()
    private let viewState = BehaviorRelay<HomeViewState>(value: .loading)
    private var viewObjects: [ListDiffable] = []
    
    init(dataManager: HomeData? = nil) {
        self.dataManager = dataManager ?? HomeDataManager()
    }
    
}

extension HomePresenter {
    
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

extension HomePresenter {
    
    var data: [ListDiffable] {
        if viewObjects.isEmpty, !dataManager.feed.isEmpty {
            //TODO: Apply presentation logic (e.g. raw date to formatted date)
            let viewModels: [FeedDiffable] = dataManager.feed.map {
                FeedDiffable(id: $0.id,
                             date: $0.unixTimestamp,
                             name: "\($0.firstName) \($0.lastName)",
                             message: $0.postBody,
                             imageURL: $0.image)
            }
            
            let listViewObject = FeedListDiffable(feed: viewModels)
            
            viewObjects.append(listViewObject)
            
            return viewObjects
        } else {
            return viewObjects as [ListDiffable]
        }
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
