//
//  FeedCell.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Nuke

class FeedCell: UICollectionViewCell {

    struct LayoutConstant {
        static var messageTopSpace: CGFloat { return 89 }
        static var heightWithImage: CGFloat { return 189.5 }
        static var heightWithoutImage: CGFloat { return 20 }
    }
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var bodyImageView: UIImageView!
    
    @IBOutlet private weak var messageLabelBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with viewModel: FeedDiffable) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        updateMessage(with: viewModel)
        updateBodyImage(with: viewModel)
    }
    
    var height: CGFloat {
        let height = messageLabel.text?.height(constraintedWidth: messageLabel.bounds.width,
                                               font: messageLabel.font) ?? 0
        return LayoutConstant.messageTopSpace + height + messageLabelBottomConstraint.constant
    }

}

private extension FeedCell {
    
    func updateBodyImage(with viewModel: FeedDiffable) {
        bodyImageView.isHidden = !viewModel.showImage
        
        guard let imageURL = viewModel.imageURL else { return }
        
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: 0.33)
        )
        
        Nuke.loadImage(with: imageURL, options: options, into: bodyImageView)
    }
    
    func updateMessage(with viewModel: FeedDiffable) {
        messageLabel.text = viewModel.message
        messageLabelBottomConstraint.constant = viewModel.showImage ?
            LayoutConstant.heightWithImage : LayoutConstant.heightWithoutImage
    }
    
}
