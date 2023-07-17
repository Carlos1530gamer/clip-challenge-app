//
//  FilterEventsUseCaseTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class FilterEventsUseCaseTests: XCTestCase {
    private var sut: FilterEventsUseCaseImpl!

    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = FilterEventsUseCaseImpl()
    }

    func test_useCaseDetectConflicts() throws {
        // Given
        let eventsRepo = EventsRepositoryMock()
        let events = try eventsRepo.getEvents()

        // When
        let result = sut.filter(events: events)

        // Then
        let eventWithConflict = result.map { $0.events }.flatMap { $0 }.first(where: { $0.conflictEvent != nil })

        XCTAssertNotNil(eventWithConflict)
    }

    func test_filterEventsAreSorted() throws {
        // Given
        let eventsRepo = EventsRepositoryLocalImpl()
        let events = try eventsRepo.getEvents()

        // When
        let result = sut.filter(events: events)

        // Then
        var areSorted = false
        let resultEvents = result.map { $0.events }.flatMap { $0 }.map { $0.event }

        for (index, resultEvent) in resultEvents.enumerated() {
            if let nextEvent = resultEvents[safe: index + 1] {
                areSorted = resultEvent.startDate <= nextEvent.startDate
            }
        }

        XCTAssertTrue(areSorted)
    }
}
