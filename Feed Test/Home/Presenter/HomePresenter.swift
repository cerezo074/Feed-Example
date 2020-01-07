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
    private var list: FeedListDiffable?
    
    init(dataManager: HomeData? = nil) {
        self.dataManager = dataManager ?? HomeDataManager()
    }
    
}

extension HomePresenter {
    
    var state: Driver<HomeViewState> {
        return viewState.asDriver(onErrorJustReturn: .showError(message: "System not available, try later please :("))
    }
    
    var latestFeedPath: IndexPath? {
        guard let list = list else { return nil }
        return IndexPath(item: list.feed.count - 1, section: 0)
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
        if let list = list, !dataManager.feed.isEmpty {
            return [list as ListDiffable]
        } else if list == nil, !dataManager.feed.isEmpty {
            let newList = createList()
            list = newList
            
            return [newList as ListDiffable]
        } else {
            return []
        }
    }
    
}

extension HomePresenter {
    
    func handle(_ result: PostResult) {
        dataManager.insertFeed(from: result)
        list = createList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewState.accept(.showFeed(showLatest: true))
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
            viewState.accept(.showFeed(showLatest: false))
        }
    }
    
    func createList() -> FeedListDiffable {
        //TODO: Apply presentation logic (e.g. raw date to formatted date)
        let viewModels: [FeedDiffable] = dataManager.feed.map {
            FeedDiffable(id: $0.id,
                         date: $0.unixTimestamp,
                         name: "\($0.firstName) \($0.lastName)",
                         message: $0.postBody,
                         imageURL: $0.image)
        }
        
        let listViewObject = FeedListDiffable(feed: viewModels)
        
        return listViewObject
    }
    
}
