//
//  FeedElement.swift
//  Fee Test
//
//  Created by Eli Pacheco Hoyos on 6/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

typealias Feed = [FeedElement]

struct FeedElement: Codable {
    let id: Int
    let firstName, lastName, postBody, unixTimestamp: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case postBody = "post_body"
        case unixTimestamp = "unix_timestamp"
        case image
    }
}
