//
//  HomeEventsViewModelIntegrationTest.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class HomeEventsViewModelIntegrationTest: XCTestCase {
    private var sut: HomeEventsViewModel!
    private var dummyRouter: HomeEventsDummyRouter!
    private var dummyView: HomeEventsDummyView!

    override func setUpWithError() throws {
        continueAfterFailure = false
        dummyRouter = HomeEventsDummyRouter()
        sut = HomeEventsViewModel(getEventsUseCase: GetEventsUseCaseImpl(eventsRepo: EventsRepositoryMock()),
                                  filterEventsUseCase: FilterEventsUseCaseImpl(),
                                  router: dummyRouter)
        dummyView = HomeEventsDummyView(viewModel: sut)
    }

    func test_getAllDataCorrectToView() async throws {
        // Given
        let extractedDate = try getDate(from: [.day, .month, .year], in: Date(timeIntervalSince1970: 1541872800))
        let expectedEvents: [EventSection] = [
            .init(dayDate: extractedDate, events: [
                .init(event: .init(title: "title 1",
                                   comments: "commnets 1",
                                   startDate: Date(timeIntervalSince1970: 1541872800),
                                   endDate: Date(timeIntervalSince1970: 1541876400)),
                      conflictEvent: nil),
                .init(event: .init(title: "title 2",
                                   comments: "commnets 2",
                                   startDate: Date(timeIntervalSince1970: 1541872800),
                                   endDate: Date(timeIntervalSince1970: 1541876400)),
                      conflictEvent: .init(title: "title 1",
                                           comments: "commnets 1",
                                           startDate: Date(timeIntervalSince1970: 1541872800),
                                           endDate: Date(timeIntervalSince1970: 1541876400)))
            ])
        ]

        // Then
        await dummyView.viewModel.viewLoaded()

        // When
        XCTAssertEqual(dummyView.input.groupedEvents, expectedEvents)
    }

    func test_selectEvent() {
        // Given
        let event = Event(title: "title 1",
                          comments: "commnets 1",
                          startDate: Date(timeIntervalSince1970: 1541872800),
                          endDate: Date(timeIntervalSince1970: 1541876400))

        // When
        dummyView.viewModel.select(event: event)

        // Then
        XCTAssertEqual(dummyRouter.showDetailsOfEventCalled, 1)
    }

    func test_showErrorAreShowedInError() async {
        // Given
        sut = HomeEventsViewModel(getEventsUseCase: GetEventsUseCaseImpl(eventsRepo: EventsRepositoryFailsMock()),
                                  filterEventsUseCase: FilterEventsUseCaseImpl(),
                                  router: dummyRouter)
        dummyView = HomeEventsDummyView(viewModel: sut)

        // When
        await dummyView.viewModel.viewLoaded()

        // Then
        XCTAssertEqual(dummyRouter.showErrorCalled, 1)
    }

    private func getDate(from components: Set<Calendar.Component>, in date: Date) throws -> Date {
        let components = Calendar.current.dateComponents(components, from: date)
        guard let date = Calendar.current.date(from: components) else {
            throw NSError(domain: "Error creating date", code: 0, userInfo: nil)
        }
        return date
    }
}
