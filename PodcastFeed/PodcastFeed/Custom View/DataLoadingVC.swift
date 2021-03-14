//
//  DataLoadingVC.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/14.
//

import UIKit

class DataLoadingVC: UIViewController {

    var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

    func showEmptyStateView(in view: UIView) {
        let emptyStateView = StateView(message: "No Episode")
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func showErrorStateView(with message: String, in view: UIView) {
        let errorStateView = StateView(message: message)
        errorStateView.frame = view.bounds
        view.addSubview(errorStateView)
    }
}
