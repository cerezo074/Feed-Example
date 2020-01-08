//
//  PostFeedViewController.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import RxSwift

class PostFeedViewController: UIViewController {
    
    @IBOutlet private weak var messageTextView: UITextView!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    private let messageViewEvent: MessageViewEvent
    private let disposeBag = DisposeBag()
    private let imagePicker = ImagePickerController()
    private let presenter: PostPresenterInterface
    
    init(presenter: PostPresenterInterface) {
        self.presenter = presenter
        self.messageViewEvent = MessageViewEvent(eventHandler: presenter)
        super.init(nibName: String(describing: PostFeedViewController.self),
                   bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupUI()
        bindViewState()
    }
    
}

private extension PostFeedViewController {
    
    func setupUI() {
        messageTextView.delegate = messageViewEvent
        let shareAction: Selector = #selector(didTapShareButton(sender:))
        let shareButton = UIBarButtonItem(title: "Share",
                                          style: .plain,
                                          target: self,
                                          action: shareAction)
        
        navigationItem.rightBarButtonItem = shareButton
    }
    
    func bindViewState() {
        presenter.state
            .drive(onNext: {[weak self] (newState) in
                self?.handle(newState)
            })
            .disposed(by: disposeBag)
    }
    
    func handle(_ state: PostViewState) {
        switch state {
        case .isReady(let message):
            stateLabel.text = message
            stateLabel.textColor = UIColor.green
        case .showError(let message):
            stateLabel.text = message
            stateLabel.textColor = UIColor.red
        case .suggestion(let message):
            stateLabel.text = message
            stateLabel.textColor = UIColor.lightGray
        case .dismiss:
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func didTapShareButton(sender: UIBarButtonItem) {
        presenter.publish(from: self)
    }
    
    @IBAction func didTapClearImage(_ sender: Any) {
        presenter.select(image: nil)
        photoImageView.image = nil
    }
    
    @IBAction func didTapPickImage(_ sender: Any) {
        imagePicker.pickImage(from: self) { [weak self] (result) in
            self?.photoImageView.image = result.image
            self?.presenter.select(image: result)
        }
    }
    
}
