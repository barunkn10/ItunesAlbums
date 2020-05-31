//
//  AppleRSSFeedAlbumsTests.swift
//  AppleRSSFeedAlbumsTests
//
//  Created by Barun  Nandi on 5/25/20.
//  Copyright © 2020 Barun Nandi. All rights reserved.
//

import XCTest
@testable import AppleRSSFeedAlbums

class AppleRSSFeedAlbumsTests: XCTestCase {
    
    func testFetchApiData() {
        let expectation = XCTestExpectation(description: "Wait for injection")
        guard let feedUrl = RSSFeedInfo.feedURL else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: feedUrl) { data, response, error in
            let feed = try? RSSFeedInfo.decode(data!)
            
            XCTAssertNotNil(feed)
            XCTAssertNotNil(feed!.feedContent)
            XCTAssertNotNil(feed!.feedContent.albums)
            
            expectation.fulfill()
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10)
        
    }
    
    func testAlbumCount() {
        let expectation = XCTestExpectation(description: "Wait for injection")
        guard let feedUrl = RSSFeedInfo.feedURL else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: feedUrl) { data, response, error in
            let feed = try? RSSFeedInfo.decode(data!)
            let albums = feed!.feedContent.albums
            
            XCTAssertEqual(albums.count, 100)
            
            expectation.fulfill()
        }
        
        dataTask.resume()
        wait(for: [expectation], timeout: 10)
    }
    
    func testNoDataMainViewExpectedItemsNil() {
        let mainViewController = RSSFeedMainViewController()
        
        XCTAssertNil(mainViewController.albums)
        XCTAssertNil(mainViewController.tableView)
    }
    
    func testMainViewMatchMockDataRowCount() {
        let albums = [getMockAlbumData(), getMockAlbumData()]
        
        let mainViewController = RSSFeedMainViewController()
        mainViewController.albums = albums
        mainViewController.viewDidLoad()
        mainViewController.tableView.reloadData()
        
        XCTAssertEqual(mainViewController.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNoDataDetailViewExpectedItemsNil() {
        let detailViewController = RSSFeedDetailViewController()
        
        XCTAssertNil(detailViewController.album)
        XCTAssertEqual(detailViewController.view.subviews.count, 0)
    }
    
    func testDetailViewMockDataStackViewAndButton() {
        
        let album = getMockAlbumData()
        
        let detailViewController = RSSFeedDetailViewController()
        detailViewController.album = album
        detailViewController.viewDidLoad()
        
        let subviews = detailViewController.view.subviews
        
        XCTAssertNotNil(subviews.first)
        XCTAssertNotNil(subviews.first as? UIStackView)
        XCTAssertNotNil(subviews.last as? UIButton)
    }
    
    private func getMockAlbumData() -> Album {
        return MockAlbum(artistName: "Gunna", releaseDate: Date(), name: "WUNNA", copyright: "℗ 2020 Young Stoner Life Records / 300 Entertainment", artworkUrl: URL(string: "https://is3-ssl.mzstatic.com/image/thumb/Music123/v4/82/db/15/82db15f2-22b2-728a-2a44-ebd7b58b2f9e/810043680837.jpg/200x200bb.png"), genre: "Hip-Hop/Rap", albumUrl: URL(string: "https://music.apple.com/us/album/wunna/1514490028?app=music"))
    }
    
}
