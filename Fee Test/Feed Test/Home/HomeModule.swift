//
//  HomeModule.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

class HomeModule {
    
    static func build() -> UINavigationController {
        let homeRouter = HomeRouter()
        let homePresenter = HomePresenter()
        let homeVC = FeedViewController(presenter: homePresenter, router: homeRouter)
        let mainNavigation = UINavigationController(rootViewController: homeVC)
        mainNavigation.navigationBar.isTranslucent = false
        
        return mainNavigation
    }
    
}
