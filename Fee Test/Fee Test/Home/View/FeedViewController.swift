//
//  FeedViewController.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet private weak var todayLabel: UILabel!
    @IBOutlet private weak var greetingLabel: UILabel!
    @IBOutlet private weak var publishMessageLabel: UILabel!
    @IBOutlet private weak var publishButton: UIButton!
    @IBOutlet private weak var feedCollectionView: UICollectionView!
    
    private let presenter: HomePresenterInterface
    private let router: HomeRouter
    
    init(presenter: HomePresenterInterface, router: HomeRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: String(describing: FeedViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

private extension FeedViewController {
    
    @IBAction func didTapPublishButton(_ sender: Any) {
        print("Show post screen")
    }
    
}
