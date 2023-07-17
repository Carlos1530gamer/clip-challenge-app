//
//  EventsRepositoryMock.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation
@testable import Upcoming_Events

final class EventsRepositoryMock: EventsRepositoryProtocol {
    func getEvents() throws -> [Event] {
        [
            .init(title: "title 1",
                  comments: "commnets 1",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400)),
            .init(title: "title 2",
                  comments: "commnets 2",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400))
        ]
    }
}
