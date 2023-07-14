//
//  EventsRepositoryLocal.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events
import XCTest

final class EventsRepositoryLocal: XCTestCase {
    var sut: EventsRepositoryLocalImpl!

    func test_retriveLocalData() throws {
        // Given
        sut = EventsRepositoryLocalImpl()

        // When
        let result = try sut.getEvents()

        // Then
        if let firstEvent = result.first {
            XCTAssertEqual(firstEvent.title, "Evening Picnic")
            XCTAssertEqual(firstEvent.startDate, Date(timeIntervalSince1970: 1541872800))
            XCTAssertEqual(firstEvent.endDate, Date(timeIntervalSince1970: 1541876400))
            XCTAssertEqual(firstEvent.comments, "Another way to have a funny time")

        } else {
            XCTFail("The result should have at least one event")
        }
    }
}
