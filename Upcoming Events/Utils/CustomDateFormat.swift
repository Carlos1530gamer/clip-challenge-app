//
//  CustomDateFormat.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

enum CustomDateFormatterErrors: Error {
    case cantConvertStringToDate
}

enum CustomDateFormat: String {
    case getEventFormat = "MMMM d, y h:mm a"
    case onlyHour12 = "h:mm a"
    case day = "EEEE d"
    case dayMonth = "EEEE d, MMMM"

    func getFormatter(locale: Locale, timeZone: TimeZone) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rawValue
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }

    func date(from string: String, locale: Locale = Locale(identifier: "en_us_POSIX"), timeZone: TimeZone = .gmt) throws -> Date {
        guard let date = getFormatter(locale: locale, timeZone: timeZone).date(from: string) else {
            throw CustomDateFormatterErrors.cantConvertStringToDate
        }
        return date
    }

    func string(from date: Date, locale: Locale = Locale(identifier: "en_us_POSIX"), timeZone: TimeZone = .gmt) -> String {
        getFormatter(locale: locale, timeZone: timeZone).string(from: date)
    }
}
