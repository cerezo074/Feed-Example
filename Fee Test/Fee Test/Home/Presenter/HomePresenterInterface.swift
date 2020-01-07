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
import IGListKit

enum HomeViewState {
    case loading
    case showFeed
    case showError(message: String)
}

typealias HomePresenterInterface = HomeViewData & HomeViewInteraction

protocol HomeViewData: class {
    var data: [ListDiffable] { get }
}

protocol HomeViewInteraction: class {
    var state: Driver<HomeViewState> { get }
    
    func viewDidLoad()
}
