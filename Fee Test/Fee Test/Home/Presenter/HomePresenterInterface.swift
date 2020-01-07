//
//  HomePresenterInterface.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum HomeViewState {
    case loading
    case showFeed
    case showError(message: String)
}

protocol HomePresenterInterface: class {
    var state: Driver<HomeViewState> { get }
    
    func viewDidLoad()
}
