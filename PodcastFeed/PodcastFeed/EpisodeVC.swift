//
//  EpisodeVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit
import FeedKit

class EpisodeVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func playButtonDidTap(_ sender: Any) { showPlayer() }
    
    private struct Segue {
        
        static let playerVC = "SeguePlayerVC"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureItem()
    }
    
    private func configureItem() {
        let item = FeedProvider.shared.getCurrentItem()
        let imageURL = item.iTunes?.iTunesImage?.attributes?.href
        episodeImage.loadImage(imageURL)
        titleLabel.text = item.title
        descriptionTextView.text = item.description
    }
    
    private func showPlayer() { performSegue(withIdentifier: Segue.playerVC, sender: nil) }
}
