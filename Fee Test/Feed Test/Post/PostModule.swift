//
//  PostModule.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 7/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

class PostModule {
    
    static func build(with resultDelegate: PostResultDelegate) -> UIViewController {
        let postPresenter = PostPresenter()
        postPresenter.resultDelegate = resultDelegate
        
        let postVC = PostFeedViewController(presenter: postPresenter)
        
        return postVC
    }
    
}
