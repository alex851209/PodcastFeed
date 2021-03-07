//
//  FeedProvider.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import Foundation
import FeedKit

class FeedProvider {
    
    static let shared = FeedProvider()
    
    private init() {}
    
    var items: [RSSFeedItem]?
    var currentIndex: Int?
    
    func fetchFeed(completion: @escaping (Result<RSSFeed?, ParserError>) -> Void) {
        let feedURL = URL(string: "https://feeds.soundcloud.com/users/soundcloud:users:322164009/sounds.rss")!
        let parser = FeedParser(URL: feedURL)
        
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                completion(.success(feed.rssFeed))
                self.items = feed.rssFeed?.items
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrentItem() -> RSSFeedItem {
        guard let currentIndex = currentIndex,
              let item = items?[currentIndex]
        else { return RSSFeedItem() }
        return item
    }
    
    func hasNextEpisode() -> Bool {
        guard let currentIndex = currentIndex else { return false }
        return currentIndex > 0 ? true : false
    }
    
    func switchToNextEpisode() { self.currentIndex? -= 1 }
}
