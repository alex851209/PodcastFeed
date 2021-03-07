//
//  FeedData.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/7.
//

import Foundation

struct Channel {
    
    let imageURLString: String
    let episodes: [Episode]
}

struct Episode {
    
    let title: String
    let description: String
    let imageURLString: String
    let pubDate: Date
    let mediaURLString: String
}
