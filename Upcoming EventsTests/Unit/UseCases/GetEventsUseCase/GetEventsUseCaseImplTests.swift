//
//  GetEventsUseCaseImplTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class GetEventsUseCaseImplTests: XCTestCase {
    private var sut: GetEventsUseCaseImpl!

    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = GetEventsUseCaseImpl(eventsRepo: EventsRepositoryMock())
    }

    func test_getEvents() async throws {
        // Given
        let expectedEvents: [Event] = [
            .init(title: "title 1",
                  comments: "commnets 1",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400)),
            .init(title: "title 2",
                  comments: "commnets 2",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400))
        ]

        // When
        let events = try await sut.getEvents()

        // Then
        XCTAssertEqual(events, expectedEvents)
    }
}
