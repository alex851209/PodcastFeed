//
//  PlayerVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit

class PlayerVC: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBAction func playPauseButtonDidTap() { togglePlayPause() }
    @IBAction func nextButtonDidTap() { switchToNextEpisode() }
    @IBAction func previousButtonDidTap() { switchToPreviousEpisode() }
    @IBAction func currentTimeDidChanged() { updateCurrentTime() }
    
    let playerManager = PlayerManager()
    var episode: Episode? {
        didSet {
            episodeImage.loadImage(episode?.imageURL)
            titleLabel.text = episode?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerManager.configureNotificationCenter()
        update()
        playEpisode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        playerManager.pause()
        playerManager.reset()
    }
    
    private func updatePlayer() {
        guard let mediaURLString = episode?.mediaURL,
              let mediaURL = URL(string: mediaURLString)
        else { return }
        
        playerManager.configurePlayer(withURL: mediaURL)
    }
    
    private func updateSlider() {
        guard let duration = playerManager.getDuration() else { return }
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = duration
        progressSlider.isContinuous = false
    }
    
    private func updateObserver() {
        playerManager.configureObserver { currentTime in
            self.progressSlider.value = currentTime
        }
    }
    
    private func update() {
        episode = FeedProvider.shared.getCurrentEpisode()
        updatePlayer()
        updateSlider()
        updateObserver()
        didFinishPlaying()
    }
    
    private func playEpisode() {
        playerManager.play()
        playPauseButton.setImage(UIImage.systemAsset(.pause), for: .normal)
    }
    
    private func pauseEpisode() {
        playerManager.pause()
        playPauseButton.setImage(UIImage.systemAsset(.play), for: .normal)
    }
    
    private func togglePlayPause() {
        playerManager.isPlaying ? pauseEpisode() : playEpisode()
    }
    
    private func switchToNextEpisode() {
        guard FeedProvider.shared.hasNextEpisode() else { return }
        FeedProvider.shared.switchToNextEpisode()
        update()
        playEpisode()
    }
    
    private func switchToPreviousEpisode() {
        guard FeedProvider.shared.hasPreviousEpisode() else { return }
        FeedProvider.shared.switchToPreviousEpisode()
        update()
        playEpisode()
    }
    
    private func updateCurrentTime() { playerManager.updateCurrentTime(to: progressSlider.value) }
    
    private func didFinishPlaying() {
        playerManager.didFinishPlaying = { [weak self] in
            guard let self = self else { return }
            self.playPauseButton.setImage(UIImage.systemAsset(.play), for: .normal)
            if FeedProvider.shared.hasNextEpisode() { self.switchToNextEpisode() }
        }
    }
}
