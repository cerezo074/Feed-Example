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
    let localImage: UIImage?
    private let imageURLString: String?
    
    init(id: Int, date: String, name: String, message: String, image: String?, localImage: UIImage?) {
        self.id = id
        self.date = date
        self.name = name
        self.message = message
        self.imageURLString = image
        self.localImage = localImage
    }
}

extension FeedDiffable {
    
    var showImage: Bool {
        return imageURL != nil || localImage != nil
    }
    
    var imageURL: URL? {
        guard let imageURLString = imageURLString,
            !imageURLString.isEmpty,
            imageURLString != " " else {
                return nil
        }
        
        return URL(string: imageURLString)
    }
    
}
