//
//  ViewController.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10 }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 130 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let reuseID = String(describing: EpisodeCell.self)
        guard let episodeCell = tableView.dequeueReusableCell(withIdentifier: reuseID,
                                                              for: indexPath) as? EpisodeCell
        else { return cell }
        return episodeCell
    }
}
