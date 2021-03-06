//
//  PlayerVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit
import FeedKit

class PlayerVC: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: RSSFeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureItem()
    }
    
    private func configureItem() {
        let imageURL = item?.iTunes?.iTunesImage?.attributes?.href
        episodeImage.loadImage(imageURL)
        titleLabel.text = item?.title
    }
}
