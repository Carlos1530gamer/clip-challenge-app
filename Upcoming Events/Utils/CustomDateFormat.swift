//
//  CustomDateFormat.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

enum CustomDateFormatterErrors: Error {
    case cantConvertStringToDate
}

enum CustomDateFormat: String {
    case getEventFormat = "MMMM d, y h:mm a"
    case onlyHour12 = "h:mm a"
    case day = "EEEE d"

    func getFormatter(locale: Locale) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rawValue
        dateFormatter.locale = locale
        return dateFormatter
    }

    func date(from string: String, locale: Locale = Locale(identifier: "en_us_POSIX")) throws -> Date {
        guard let date = getFormatter(locale: locale).date(from: string) else {
            throw CustomDateFormatterErrors.cantConvertStringToDate
        }
        return date
    }

    func string(from date: Date, locale: Locale = Locale(identifier: "en_us_POSIX")) -> String {
        getFormatter(locale: locale).string(from: date)
    }
}
