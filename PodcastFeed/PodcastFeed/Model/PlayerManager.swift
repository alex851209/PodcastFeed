//
//  PlayerManager.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/11.
//

import Foundation
import AVFoundation

class PlayerManager {
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var didFinishPlaying: (() -> Void)?
    var isPlaying: Bool {
        get { return player?.timeControlStatus == AVPlayer.TimeControlStatus.playing }
    }
    
    func configurePlayer(withURL url: URL) {
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    func play() { player?.play() }
    
    func pause() { player?.pause() }
    
    func updateCurrentTime(to time: Float) {
        let seconds = Int64(time)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        player?.seek(to: targetTime)
    }
    
    func getDuration() -> Float? {
        guard let duration = playerItem?.asset.duration else { return nil }
        let seconds = CMTimeGetSeconds(duration)
        return Float(seconds)
    }
    
    func configureObserver(completion: @escaping (Float) -> Void) {
        player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            if self.player?.currentItem?.status == .readyToPlay {
                guard let currentTime = self.player?.currentTime() else { return }
                let seconds = CMTimeGetSeconds(currentTime)
                completion(Float(seconds))
            }
        }
    }
    
    func configureNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
    
    func reset() { NotificationCenter.default.removeObserver(self) }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) { didFinishPlaying?() }
}
