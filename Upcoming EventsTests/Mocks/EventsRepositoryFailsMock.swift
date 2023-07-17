//
//  EventsRepositoryFailsMock.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation
@testable import Upcoming_Events

final class EventsRepositoryFailsMock: EventsRepositoryProtocol {
    func getEvents() throws -> [Event] {
        throw NSError(domain: "test", code: 0, userInfo: nil)
    }
}
