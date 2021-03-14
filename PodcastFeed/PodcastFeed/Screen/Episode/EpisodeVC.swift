//
//  EpisodeVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit

class EpisodeVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func playButtonDidTap(_ sender: Any) { showPlayer() }
    
    var episode: Episode? {
        didSet {
            episodeImage.loadImage(episode?.imageURL)
            titleLabel.text = episode?.title
            contentTextView.text = episode?.content
        }
    }
    
    private struct Segue {
        
        static let playerVC = "SeguePlayerVC"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureEpisode()
    }
    
    private func configureEpisode() { episode = FeedProvider.shared.getCurrentEpisode() }
    
    private func showPlayer() { performSegue(withIdentifier: Segue.playerVC, sender: nil) }
}
