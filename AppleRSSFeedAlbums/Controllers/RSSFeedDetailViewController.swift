//
//  RSSFeedDetailViewController.swift
//  AppleRSSFeedAlbums
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import UIKit

final class RSSFeedDetailViewController: UIViewController {
    
    var album: Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutObjects()
    }
    
    @objc func viewButtonTapped() {
        let itunesStorePrefix = "itms://itunes.apple.com/"
        guard let url = album.albumUrl else {
            return
        }
        
        let albumSuffix = url.pathComponents.dropFirst().joined(separator: "/")
        guard
            let sUrl = URL(string: itunesStorePrefix + albumSuffix),
            UIApplication.shared.canOpenURL(sUrl)
            else {
                return
        }
        UIApplication.shared.open(url)
    }
    
    
    internal func layoutObjects() {
        guard let album = album else { return }
        view.backgroundColor = .systemBackground
        
        guard let aUrl = album.artworkUrl else {
            return
        }
        
        let albumImageView = UIImageView(image: UIImage(named: "placeholderImage"))
        RSSFeedImageCache.image(for: aUrl) { image in
            albumImageView.image = image
        }
        
        let nameLabel = UILabel()
        nameLabel.text = album.name
        nameLabel.font = nameLabel.font.withSize(20)
        nameLabel.numberOfLines = 0
        nameLabel.accessibilityIdentifier = "Album name"
        
        let artistLabel = UILabel()
        
        artistLabel.text = "Artist: \(String(describing: album.artistName))"
        artistLabel.font = artistLabel.font.withSize(15)
        artistLabel.numberOfLines = 0
        artistLabel.accessibilityIdentifier = "Artist name"
        
        let genreLabel = UILabel()
        genreLabel.text = "Genre: \(album.genre ?? "")"
        genreLabel.font = genreLabel.font.withSize(15)
        genreLabel.accessibilityIdentifier = "Genre"
        
        let releaseLabel = UILabel()
        guard let rDate = album.releaseDate else {
            return
        }
            
        releaseLabel.text = "Release Date: \(DateFormatter.rssFeedFormatter.string(from: rDate))"
        releaseLabel.font = releaseLabel.font.withSize(15)
        releaseLabel.accessibilityIdentifier = "Release date"
        
        let copyright = UILabel()
        copyright.text = "Copyright: \(String(describing:album.copyright))"
        copyright.numberOfLines = 0
        copyright.font = copyright.font.withSize(15)
        copyright.accessibilityIdentifier = "Copyright"
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16.0
        stackView.accessibilityIdentifier = "Album Stack View"
        
        stackView.addArrangedSubview(albumImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseLabel)
        stackView.addArrangedSubview(copyright)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let viewButton = UIButton()
        viewButton.setTitle("View in iTunes Store", for: .normal)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        viewButton.backgroundColor = .clear
        viewButton.layer.cornerRadius = 10
        viewButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        viewButton.addTarget(self, action: #selector(self.viewButtonTapped), for: .touchUpInside)
        viewButton.accessibilityIdentifier = "Button to view in iTunes Store"
        view.addSubview(viewButton)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        albumImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        viewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        viewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        viewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        viewButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
