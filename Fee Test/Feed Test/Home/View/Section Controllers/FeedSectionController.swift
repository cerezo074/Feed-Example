//
//  FeedSectionController.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import IGListKit

class FeedSectionController: ListSectionController {
    
    private var data: FeedListDiffable
    
    init(data: FeedListDiffable) {
        self.data = data
    }
    
}

extension FeedSectionController {
    
    override func numberOfItems() -> Int {
        return data.feed.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize else {
            return .zero
        }
        
        return CGSize(width: containerSize.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let dequeuedCell = collectionContext?.dequeueReusableCell(withNibName: String(describing: FeedCell.self),
                                                                  bundle: nil,
                                                                  for: self,
                                                                  at: index)
        
        guard let feedCell = dequeuedCell as? FeedCell else {
            assertionFailure("Invalid state for section controller")
            return UICollectionViewCell()
        }
        
        let viewModel = data.feed[index]
        feedCell.setup(with: viewModel)
        
        return feedCell
    }
    
    override func didUpdate(to object: Any) {
        guard let data = object as? FeedListDiffable else {
            return
        }
        
        self.data = data
    }
    
}
