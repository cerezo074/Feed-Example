//
//  FeedCell.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with viewModel: FeedDiffable) {
        messageLabel.text = viewModel.message
    }

}
