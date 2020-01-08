//
//  FeedElement.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

typealias Feed = [FeedElement]

struct FeedElement: Codable {
    let id: Int
    let firstName, lastName, postBody, unixTimestamp: String
    let image: String?
    let localImage: UIImage?

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        id = try rootContainer.decode(Int.self, forKey: .id)
        firstName = try rootContainer.decode(String.self, forKey: .firstName)
        lastName = try rootContainer.decode(String.self, forKey: .lastName)
        postBody = try rootContainer.decode(String.self, forKey: .postBody)
        unixTimestamp = try rootContainer.decode(String.self, forKey: .unixTimestamp)
        image = try rootContainer.decodeIfPresent(String.self, forKey: .image)
        localImage = nil
    }
    
    init(id: Int = -1,
         firstName: String = "",
         lastName: String = "",
         postBody: String = "",
         unixTimestamp: String = "",
         image:  String? = nil,
         localImage: UIImage? = nil)
    {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.postBody = postBody
        self.unixTimestamp = unixTimestamp
        self.image = image
        self.localImage = localImage
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case postBody = "post_body"
        case unixTimestamp = "unix_timestamp"
        case image
    }
}
