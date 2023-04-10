//
//  DateFormatter.swift
//  MarshalOne
//
//  Created by Veronika on 31.03.2023.
//

import Foundation

final class CustomDateFormatter: DateFormatter {
    let formatter1 = DateFormatter()
    
    var dateString = ""
    
    func formatDate(from date: String) -> String {
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter1.locale = Locale(identifier: "en_US_POSIX")
        if let date2 = formatter1.date(from: date) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "EEEE, MMM d, yyyy"
            formatter2.locale = Locale(identifier: "en_US_POSIX")
            dateString = formatter2.string(from: date2)
        }
        return dateString
    }
}
