//
//  GetEventsUseCaseImplTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events
import XCTest

final class GetEventsUseCaseImplTests: XCTestCase {
    var sut: GetEventsUseCaseImpl!

    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = GetEventsUseCaseImpl(eventsRepo: EventsRepositoryMock())
    }

    func test_getEvents() async throws {
        // Given
        let expectedEvents = [
            Event(title: "title 1",
                  comments: "commnets 1",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400))
        ]

        // When
        let events = try await sut.getEvents()

        // Then
        XCTAssertEqual(events, expectedEvents)
    }
}
