//
//  RSSFeedImageCache.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import UIKit

typealias CachedImageLoader = ((UIImage) -> ())

public final class RSSFeedImageCache {
    
    private static var cached: [URL : UIImage] = [:]
    
    public static func image(for url: URL, completionHandler: @escaping (UIImage) -> Void) {
        
        if let cachedImage = cached[url] {
            completionHandler(cachedImage)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard
                error == nil,
                let data = data,
                let image = UIImage(data: data)
            else {
                return
            }
            
            cached[url] = image
            DispatchQueue.main.async {
                completionHandler(image)
            }
        })
        
        task.resume()
    }
}

