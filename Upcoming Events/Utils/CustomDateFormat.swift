//
//  CustomDateFormat.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

enum CustomDateFormat: String {
    case getEventFormat = "MMMM d, y h:mm a"
    case onlyHour12 = "h:mm a"
    case day = "EEEE d"

    func getFormatter(locale: Locale) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self.rawValue
        dateFormatter.locale = locale
        return dateFormatter
    }
}
