//
//  UIView+Ext.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/14.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
