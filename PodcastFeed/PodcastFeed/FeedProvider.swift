//
//  FeedProvider.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import Foundation
import FeedKit

class FeedProvider {
    
    func fetchFeed(completion: @escaping (Result<RSSFeed?, ParserError>) -> Void) {
        let feedURL = URL(string: "https://feeds.soundcloud.com/users/soundcloud:users:322164009/sounds.rss")!
        let parser = FeedParser(URL: feedURL)
        
        parser.parseAsync { result in
            switch result {
            case .success(let feed): completion(.success(feed.rssFeed))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
