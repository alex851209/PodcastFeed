//
//  StateView.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/14.
//

import UIKit

class StateView: UIView {

    let messageLabel = UILabel()
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }

    private func configure() {
        addSubviews(messageLabel, logoImageView)

        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.image = UIImage.asset(.logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: -30),

            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
