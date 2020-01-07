//
//  FeedDataSource.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import IGListKit

typealias FeedDataEventHandler = HomeViewData

class FeedDataSource: NSObject {
    
    private unowned let eventHandler: FeedDataEventHandler
    
    init(eventHandler: FeedDataEventHandler) {
        self.eventHandler = eventHandler
    }
    
}

extension FeedDataSource: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return eventHandler.data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case let feedVM as FeedListDiffable:
            let sectionController = FeedSectionController(data: feedVM)
            
            return sectionController
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
