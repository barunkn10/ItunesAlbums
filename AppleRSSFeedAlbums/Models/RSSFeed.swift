//
//  RSSFeed.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import Foundation

struct RSSFeed: Codable {
    let feedContent: RSSFeedData
    
    enum CodingKeys: String, CodingKey {
        case feedContent = "feed"
    }
}
