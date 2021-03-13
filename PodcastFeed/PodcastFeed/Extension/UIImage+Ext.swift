//
//  UIImage+Ext.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/12.
//

import UIKit

enum ImageAsset: String {
    
    case play = "play.circle"
    case pause = "pause.circle"
}

extension UIImage {
    
    static func asset(_ asset: ImageAsset) -> UIImage? { return UIImage(systemName: asset.rawValue) }
}
