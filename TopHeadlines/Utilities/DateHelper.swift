//
//  DateHelper.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/28/20.
//

import Foundation

class DateHelper {
    static var monthDayYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()

    static func convertToMonthDayYearFormat(_ date: Date) -> String {
        return monthDayYearDateFormatter.string(from: date)
    }
    
    
    static var timeDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    static func convertToTimeFormat(_ date: Date) -> String {
        return timeDateFormatter.string(from: date)
    }
}
