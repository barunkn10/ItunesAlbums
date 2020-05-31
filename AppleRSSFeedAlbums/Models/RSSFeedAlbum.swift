//
//  RSSFeedAlbum.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import Foundation

protocol Album {
    var artistName: String? {get set}
    var releaseDate: Date? {get set}
    var name: String? {get set}
    var copyright: String? {get set}
    var artworkUrl: URL? {get set}
    var genre: String? {get set}
    var albumUrl: URL? {get set}
}

struct RSSFeedAlbum: Album, Codable {
    var artistName: String?
    var releaseDate: Date?
    var name: String?
    var copyright: String?
    var artworkUrl: URL?
    var genre: String?
    var albumUrl: URL?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        artistName = try container.decode(String.self, forKey: .artistName)
        
        let dateString = (try? container.decode(String.self, forKey: .releaseDate)) ?? ""
        releaseDate = DateFormatter.yyyyMMdd.date(from: dateString) ?? Date()
        
        name = try container.decode(String.self, forKey: .name)
        copyright = try container.decode(String.self, forKey: .copyright)
        artworkUrl = try container.decode(URL.self, forKey: .artworkUrl)
        
        struct Genre: Decodable { let name: String }
        let genres = try? container.decode([Genre].self, forKey: .genre)
        genre = genres?.first?.name ?? ""
        
        albumUrl = try container.decode(URL.self, forKey: .albumUrl)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(artistName, forKey: .artistName)
        try container.encode(name, forKey: .name)
        try container.encode(copyright, forKey: .copyright)
        try container.encode(artworkUrl, forKey: .artworkUrl)
        try container.encode(albumUrl, forKey: .albumUrl)
    }

    func encodedJSONString() -> String? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case releaseDate = "releaseDate"
        case name = "name"
        case copyright = "copyright"
        case artworkUrl = "artworkUrl100"
        case genre = "genres"
        case albumUrl = "url"
    }
}

struct MockAlbum: Album {
    var artistName: String?
    var releaseDate: Date?
    var name: String?
    var copyright: String?
    var artworkUrl: URL?
    var genre: String?
    var albumUrl: URL?
    
    init(artistName: String?, releaseDate: Date?, name: String?, copyright: String?, artworkUrl: URL?, genre: String?, albumUrl: URL?) {
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.name = name
        self.copyright = copyright
        self.artworkUrl = artworkUrl
        self.genre = genre
        self.albumUrl = albumUrl
    }
}

