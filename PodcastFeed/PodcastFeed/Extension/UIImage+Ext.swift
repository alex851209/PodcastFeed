//
//  UIImage+Ext.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/12.
//

import UIKit

enum SystemAsset: String {
    
    case play = "play.circle"
    case pause = "pause.circle"
}

enum ImageAsset: String {
    
    case logo = "logo"
}

extension UIImage {
    
    static func systemAsset(_ asset: SystemAsset) -> UIImage? { return UIImage(systemName: asset.rawValue) }
    
    static func asset(_ asset: ImageAsset) -> UIImage? { return UIImage(named: asset.rawValue) }
}
