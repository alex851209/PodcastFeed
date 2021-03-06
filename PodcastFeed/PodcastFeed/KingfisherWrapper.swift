//
//  KingfisherWrapper.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import Foundation
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {
        guard urlString != nil else { return }
        let url = URL(string: urlString!)
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(.fade(0.4))])
    }
}
