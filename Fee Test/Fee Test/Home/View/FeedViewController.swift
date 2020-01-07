//
//  FeedViewController.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit

class FeedViewController: UIViewController {
    
    @IBOutlet private weak var todayLabel: UILabel!
    @IBOutlet private weak var greetingLabel: UILabel!
    @IBOutlet private weak var publishMessageLabel: UILabel!
    @IBOutlet private weak var publishButton: UIButton!
    @IBOutlet private weak var feedCollectionView: UICollectionView!
    @IBOutlet private weak var loaderView: UIActivityIndicatorView!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    private let presenter: HomeViewInteraction
    private let router: HomeRouter
    private let dataSource: FeedDataSource
    private let disposeBag = DisposeBag()
    
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    
    init(presenter: HomePresenterInterface, router: HomeRouter) {
        self.presenter = presenter
        self.router = router
        self.dataSource = FeedDataSource(eventHandler: presenter)
        super.init(nibName: String(describing: FeedViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderView.startAnimating()
        bindViewState()
        setupCollection()
        presenter.viewDidLoad()
    }

}

private extension FeedViewController {
    
    func bindViewState() {
        presenter.state
            .drive(onNext: { [weak self] (newState) in
                self?.handle(newState)
            })
            .disposed(by: disposeBag)
    }
    
    func handle(_ viewState: HomeViewState) {
        switch viewState {
        case .loading:
            feedCollectionView.isHidden = true
            errorMessageLabel.isHidden = true
            loaderView.isHidden = false
        case .showError(let message):
            feedCollectionView.isHidden = true
            errorMessageLabel.isHidden = false
            loaderView.isHidden = true
            errorMessageLabel.text = message
        case .showFeed:
            feedCollectionView.isHidden = false
            errorMessageLabel.isHidden = true
            loaderView.isHidden = true
            loaderView.stopAnimating()
            adapter.performUpdates(animated: true)
        }
    }
    
    func setupCollection() {
        adapter.dataSource = dataSource
        adapter.collectionView = feedCollectionView
    }
    
    @IBAction func didTapPublishButton(_ sender: Any) {
        print("Show post screen")
    }
    
}
