//
//  RSSFeedData.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import Foundation

struct RSSFeedData: Codable {
    let albums : [RSSFeedAlbum]
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}
