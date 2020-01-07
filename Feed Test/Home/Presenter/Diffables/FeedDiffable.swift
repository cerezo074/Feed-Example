//
//  FeedDiffable.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import IGListKit

class FeedListDiffable: NSObject {
    var feed: [FeedDiffable]
    
    init(feed: [FeedDiffable]) {
        self.feed = feed
    }
}

class FeedDiffable: NSObject {
    let id: Int
    let date: String
    let name: String
    let message: String
    let imageURL: String?
    
    init(id: Int, date: String, name: String, message: String, imageURL: String?) {
        self.id = id
        self.date = date
        self.name = name
        self.message = message
        self.imageURL = imageURL
    }
}
