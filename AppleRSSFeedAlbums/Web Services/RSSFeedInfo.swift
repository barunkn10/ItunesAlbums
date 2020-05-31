//
//  RSSFeedInfo.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import UIKit

public enum RSSFeedError: Error {
    case rssFetchFailure
    case rssDecodeFailure
}

public enum RSSFeedInfo {
    
    typealias TaskClosure = (data: Data?, response: URLResponse?, error: Error?)
    
    static let feedURL = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json")
    
    private static let session = URLSession(configuration: .default)
    private static var dataTask: URLSessionDataTask?
    
    static func inject(into mainVC: RSSFeedMainViewController) {
        dataTask?.cancel()
        
        guard let url = feedURL else {
            return
        }
        
        dataTask = session.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            guard
                let data = try? retrievedData(for: (data, response, error)),
                let feed = try? decode(data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                mainVC.albums = feed.feedContent.albums
                mainVC.tableView.reloadData()
            }
        }
        
        dataTask?.resume()
    }
    
    static func retrievedData(for closureElements: TaskClosure) throws -> Data {
        guard
            closureElements.error == nil,
            let data = closureElements.data
            else {
                throw RSSFeedError.rssFetchFailure
        }
        return data
    }
    
    static func decode(_ data: Data) throws -> RSSFeed {
        do {
            return try JSONDecoder().decode(RSSFeed.self, from: data)
        } catch {
            print(error)
            throw RSSFeedError.rssDecodeFailure
        }
    }
}
