//
//  PlayerVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit
import AVFoundation

class PlayerVC: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBAction func playPauseButtonDidTap() { togglePlayPause(playPauseButton) }
    @IBAction func nextButtonDidTap() { switchToNextEpisode() }
    @IBAction func previousButtonDidTap() { switchToPreviousEpisode() }
    @IBAction func currentTimeDidChanged(_ sender: UISlider) { updateCurrentTime(sender) }
    
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNotificationCenter()
        playEpisode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        player.pause()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureEpisode() {
        episode = FeedProvider.shared.getCurrentEpisode()
        episodeImage.loadImage(episode?.imageURLString)
        titleLabel.text = episode?.title
    }
    
    private func configurePlayer() {
        guard let episodeURL = URL(string: episode?.mediaURLString ?? "") else { return }
        playerItem = AVPlayerItem(url: episodeURL)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    private func configureSlider() {
        let duration = playerItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = Float(seconds)
        progressSlider.isContinuous = false
    }
    
    private func configureObserver() {
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { time in
            if self.player.currentItem?.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(self.player.currentTime())
                self.progressSlider.value = Float(currentTime)
            }
        }
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
    
    private func playEpisode() {
        playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        configureEpisode()
        configurePlayer()
        configureSlider()
        configureObserver()
    }
    
    private func togglePlayPause(_ sender: UIButton) {
        switch player.timeControlStatus {
        case .playing:
            player.pause()
            sender.setImage(UIImage(systemName: "play.circle"), for: .normal)
        case .paused:
            player.play()
            sender.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        default: break
        }
    }
    
    private func switchToNextEpisode() {
        guard FeedProvider.shared.hasNextEpisode() else { return }
        FeedProvider.shared.switchToNextEpisode()
        playEpisode()
    }
    
    private func switchToPreviousEpisode() {
        guard FeedProvider.shared.hasPreviousEpisode() else { return }
        FeedProvider.shared.switchToPreviousEpisode()
        playEpisode()
    }
    
    private func updateCurrentTime(_ sender: UISlider) {
        let seconds = Int64(sender.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        guard FeedProvider.shared.hasNextEpisode() else {
            playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            return
        }
        switchToNextEpisode()
    }
}
