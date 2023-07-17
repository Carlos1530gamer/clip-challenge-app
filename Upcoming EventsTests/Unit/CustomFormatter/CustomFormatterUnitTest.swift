//
//  CustomFormatterUnitTest.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class CustomFormatterUnitTest: XCTestCase {
    private var sut: CustomDateFormat = .day

    func test_convertToStringEventFormat() {
        // Given
        let dates: [Date] = [
            Date(timeIntervalSince1970: 1689342300),
            Date(timeIntervalSince1970: 1689428700),
            Date(timeIntervalSince1970: 1689515100),
            Date(timeIntervalSince1970: 1692193500),
            Date(timeIntervalSince1970: 1723815900),
        ]
        let expected = [
            "July 14, 2023 1:45 PM",
            "July 15, 2023 1:45 PM",
            "July 16, 2023 1:45 PM",
            "August 16, 2023 1:45 PM",
            "August 16, 2024 1:45 PM",
        ]
        sut = .getEventFormat

        // When
        let results = dates.map { sut.string(from: $0, locale: Locale(identifier: "en_us_POSIX")) }

        // Then
        for result in results.enumerated() {
            XCTAssertEqual(result.element, expected[result.offset])
        }
    }

    func test_convertDateEventFormat() throws {
        // Given
        let stringDates: [String] = [
            "July 14, 2023 1:45 PM",
            "July 15, 2023 1:45 PM",
            "July 16, 2023 1:45 PM",
            "August 16, 2023 1:45 PM",
            "August 16, 2024 1:45 PM",
        ]
        let expected = [
            Date(timeIntervalSince1970: 1689342300),
            Date(timeIntervalSince1970: 1689428700),
            Date(timeIntervalSince1970: 1689515100),
            Date(timeIntervalSince1970: 1692193500),
            Date(timeIntervalSince1970: 1723815900),
        ]
        sut = .getEventFormat

        // When
        var results: [Date] = []
        for stringDate in stringDates {
            try results.append(sut.date(from: stringDate, locale: Locale(identifier: "en_us_POSIX")))
        }

        // Then
        for result in results.enumerated() {
            XCTAssertEqual(result.element, expected[result.offset])
        }
    }
}
