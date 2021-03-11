//
//  EpisodeCell.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func layoutCell(with episode: Episode) {
        episodeImage.loadImage(episode.imageURL)
        titleLabel.text = episode.title
        dateLabel.text = episode.pubDate
    }
}
