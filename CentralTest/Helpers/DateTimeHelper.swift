//
//  DateTimeHelper.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//
import Foundation

class DateTimeHelper {
    static func displayedDate(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "MMM dd, HH:mm"
            return formatter.string(from: date)
        }
        return ""
    }
}
