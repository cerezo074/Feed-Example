//
//  HomeRouter.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    
    func handle(transition: HomeTransition) {
        switch transition {
        case .showPost(let viewController, let resultDelegate):
            showPost(from: viewController, with: resultDelegate)
        }
    }
    
}

private extension HomeRouter {

    func showPost(from viewController: UIViewController, with resultDelegate: PostResultDelegate) {
        guard let navigation = viewController.navigationController else {
             return
        }
        
        let postVC = PostModule.build(with: resultDelegate)
        navigation.pushViewController(postVC, animated: true)
    }
    
}
