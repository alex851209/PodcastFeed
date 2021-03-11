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
              let imageURL = feed.rssFeed?.image?.url
        else { return nil }
        
        for item in items {
            guard let episode = makeEpisodeFrom(item: item) else { return nil }
            episodes.append(episode)
        }
        
        let channel = Channel()
        channel.imageURL = imageURL
        channel.episodes = episodes
        return channel
    }
    
    private func makeEpisodeFrom(item: RSSFeedItem) -> Episode? {
        guard let title = item.title,
              let content = item.description,
              let imageURL = item.iTunes?.iTunesImage?.attributes?.href,
              let mediaURL = item.enclosure?.attributes?.url,
              let pubDate = item.pubDate
        else { return nil }
        
        let dateString = Date.dateToDateString(pubDate)
        let episode = Episode()
        episode.title = title
        episode.content = content
        episode.imageURL = imageURL
        episode.mediaURL = mediaURL
        episode.pubDate = dateString
        return episode
    }
}
