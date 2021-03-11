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
    
    var episodes = [Episode]()
    var currentIndex: Int?
    
    func fetchFeed(completion: @escaping (Result<Channel?, ParserError>) -> Void) {
        let feedURL = URL(string: "https://feeds.soundcloud.com/users/soundcloud:users:322164009/sounds.rss")!
        let parser = FeedParser(URL: feedURL)
        
        parser.parseAsync { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let feed):
                let channel = self.makeChannelFrom(feed: feed)
                completion(.success(channel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCurrentEpisode() -> Episode? {
        guard let currentIndex = currentIndex else { return nil }
        return episodes[currentIndex]
    }
    
    func hasNextEpisode() -> Bool {
        guard let currentIndex = currentIndex else { return false }
        return currentIndex > 0 ? true : false
    }
    
    func hasPreviousEpisode() -> Bool {
        guard let currentIndex = currentIndex else { return false }
        return currentIndex < episodes.count - 1 ? true : false
    }
    
    func switchToNextEpisode() { currentIndex? -= 1 }
    
    func switchToPreviousEpisode() { currentIndex? += 1 }
    
    private func makeChannelFrom(feed: Feed) -> Channel? {
        guard let items = feed.rssFeed?.items,
              let imageURLString = feed.rssFeed?.image?.url
        else { return nil }
        
        for item in items {
            guard let episode = makeEpisodeFrom(item: item) else { return nil }
            episodes.append(episode)
        }
        return Channel(imageURLString: imageURLString, episodes: episodes)
    }
    
    private func makeEpisodeFrom(item: RSSFeedItem) -> Episode? {
        guard let title = item.title,
              let description = item.description,
              let imageURLString = item.iTunes?.iTunesImage?.attributes?.href,
              let mediaURLString = item.enclosure?.attributes?.url,
              let pubDate = item.pubDate
        else { return nil }
        
        let episode = Episode(title: title,
                              description: description,
                              imageURLString: imageURLString,
                              pubDate: pubDate,
                              mediaURLString: mediaURLString)
        return episode
    }
}
