//
//  HomePresenter.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift

protocol HomePresenterInterface: class {
    func viewDidLoad()
}

class HomePresenter {
    
    private let dataManager: HomeData
    private let disposeBag = DisposeBag()
    
    init(dataManager: HomeData? = nil) {
        self.dataManager = dataManager ?? HomeDataManager()
    }
    
}

extension HomePresenter: HomePresenterInterface {
    
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
        print(dataManager.feed)
    }
    
}
