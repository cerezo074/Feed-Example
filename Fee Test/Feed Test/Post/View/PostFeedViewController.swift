//
//  PostFeedViewController.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class PostFeedViewController: UIViewController {
    
    let presenter: PostPresenterInterface
    
    init(presenter: PostPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: String(describing: PostFeedViewController.self),
                   bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
    
}

extension PostFeedViewController {
    
    @IBAction func didTapGeneratePostButton(_ sender: Any) {
        presenter.generateRandomPost()
        navigationController?.popViewController(animated: true)
    }
    
}
