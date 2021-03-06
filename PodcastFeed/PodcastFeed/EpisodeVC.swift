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
        
        static let episodeVC = "SeguePlayerVC"
    }
    
    var item: RSSFeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureItem()
    }
    
    private func configureItem() {
        let imageURL = item?.iTunes?.iTunesImage?.attributes?.href
        episodeImage.loadImage(imageURL)
        titleLabel.text = item?.title
        descriptionTextView.text = item?.description
    }
    
    private func showPlayer() { performSegue(withIdentifier: Segue.episodeVC, sender: nil) }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerVC = segue.destination as? PlayerVC else { return }
        playerVC.item = item
    }
}
