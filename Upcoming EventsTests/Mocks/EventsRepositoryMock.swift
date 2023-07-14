//
//  EventsRepositoryMock.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
@testable import Upcoming_Events

final class EventsRepositoryMock: EventsRepositoryProtocol {
    func getEvents() throws -> [Event] {
        [
            .init(title: "title 1",
                  comments: "commnets 1",
                  startDate: Date(timeIntervalSince1970: 1541872800),
                  endDate: Date(timeIntervalSince1970: 1541876400))
        ]
    }
}
