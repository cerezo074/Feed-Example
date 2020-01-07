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
        super.init()
        inset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        minimumLineSpacing = 20
    }
    
}

extension FeedSectionController {
    
    override func numberOfItems() -> Int {
        return data.feed.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let containerSize = collectionContext?.containerSize,
            let cell = updateCell(at: index) else {
            return .zero
        }
        
        return CGSize(width: containerSize.width, height: cell.getHeight(constrainedWidth: containerSize.width))
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let feedCell = updateCell(at: index) else {
            assertionFailure("Invalid state for section controller")
            return UICollectionViewCell()
        }
        
        return feedCell
    }
    
    override func didUpdate(to object: Any) {
        guard let data = object as? FeedListDiffable else {
            return
        }
        
        self.data = data
    }
    
}

private extension FeedSectionController {
    
    func updateCell(at index: Int) -> FeedCell? {
        let dequeuedCell = collectionContext?.dequeueReusableCell(withNibName: String(describing: FeedCell.self),
                                                                  bundle: nil,
                                                                  for: self,
                                                                  at: index)
        
        guard let feedCell = dequeuedCell as? FeedCell else { return nil }
        let viewModel = data.feed[index]
        feedCell.setup(with: viewModel)
        
        return feedCell
    }
    
}
