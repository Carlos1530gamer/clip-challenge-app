//
//  String+Extension.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

enum StringExtensionErrors: Error {
    case cantConvertStringToDate
}

extension String {
    func toDate(format: CustomDateFormat, locale: Locale = Locale(identifier: "en_us_POSIX")) throws -> Date {
        guard let date = format.getFormatter(locale: locale).date(from: self) else {
            throw StringExtensionErrors.cantConvertStringToDate
        }
        return date
    }
}
