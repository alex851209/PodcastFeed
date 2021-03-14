//
//  HomeVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit

class HomeVC: DataLoadingVC {

    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var provider = FeedProvider.shared
    
    private struct Segue {
        
        static let episodeVC = "SegueEpisodeVC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchFeed()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchFeed() {
        showLoadingView()
        
        provider.fetchFeed { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let channel):
                DispatchQueue.main.async {
                    if channel.episodes.count > 0 {
                        self.channelImage.loadImage(channel.imageURL)
                        self.tableView.reloadData()
                    } else {
                        self.showEmptyStateView(in: self.view)
                    }
                    self.dismissLoadingView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorStateView(with: error.localizedDescription, in: self.view)
                    self.dismissLoadingView()
                }
            }
        }
    }
}

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        provider.currentIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Segue.episodeVC, sender: nil)
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.episodes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 130 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let reuseID = String(describing: EpisodeCell.self)
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? EpisodeCell
        else { return cell }
        
        let episode = provider.episodes[indexPath.row]
        episodeCell.layoutCell(with: episode)
        
        return episodeCell
    }
}
