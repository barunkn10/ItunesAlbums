//
//  RSSFeedTableViewCell.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import UIKit

class RSSFeedTableViewCell: UITableViewCell {
    
    public let REUSE_IDENTIFIER = "rssFeedContentCell"

    let albumName = UILabel()
    let artistName = UILabel()
    var albumImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let views = ["albumName" : albumName, "artistName" : artistName, "albumImage" : albumImage]
        
        albumName.accessibilityIdentifier = "Album name"
        artistName.accessibilityIdentifier = "Artist name"
        albumImage.accessibilityIdentifier = "Album image"

        albumName.translatesAutoresizingMaskIntoConstraints = false
        artistName.translatesAutoresizingMaskIntoConstraints = false
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(albumName)
        contentView.addSubview(artistName)
        contentView.addSubview(albumImage)
        
        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumImage(60)]-[albumName]-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumImage]-[artistName]-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumImage(60@750)]-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumName]-[artistName]-|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
