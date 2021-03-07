//
//  PlayerVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit
import AVFoundation
import FeedKit

class PlayerVC: UIViewController {

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBAction func playPauseButtonDidTap(_ sender: UIButton) { togglePlayPause(sender) }
    @IBAction func backwardButtonDidTap() { fastBackward() }
    @IBAction func forwardButtonDidTap() { fastForward() }
    @IBAction func currentTimeDidChanged(_ sender: UISlider) { updateCurrentTime(sender) }
    
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var item: RSSFeedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureItem()
        configureAVPlayer()
        configureProgressSlider()
        configureObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        player.pause()
    }
    
    private func configureItem() {
        let imageURL = item?.iTunes?.iTunesImage?.attributes?.href
        episodeImage.loadImage(imageURL)
        titleLabel.text = item?.title
    }
    
    private func configureAVPlayer() {
        guard let episodeURL = URL(string: item?.enclosure?.attributes?.url ?? "") else { return }
        playerItem = AVPlayerItem(url: episodeURL)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
    
    private func configureProgressSlider() {
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
    
    private func fastForward() {
        let targetTime = player.currentTime() + CMTimeMake(value: 10, timescale: 1)
        player.seek(to: targetTime)
    }
    
    private func fastBackward() {
        let targetTime = player.currentTime() - CMTimeMake(value: 10, timescale: 1)
        player.seek(to: targetTime)
    }
    
    private func updateCurrentTime(_ sender: UISlider) {
        let seconds = Int64(sender.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
}
