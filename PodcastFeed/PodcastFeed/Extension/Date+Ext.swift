//
//  Date+Ext.swift
//  PodcastFeed
//
//  Created by shuo on 2021/3/6.
//

import Foundation

extension Date {
    
    static func dateToDateString(_ date: Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}
