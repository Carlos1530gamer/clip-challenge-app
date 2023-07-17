//
//  GetEventsUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

final class GetEventsUseCaseImpl: GetEventsUseCaseProtocol {
    let eventsRepo: EventsRepositoryProtocol

    init(eventsRepo: EventsRepositoryProtocol) {
        self.eventsRepo = eventsRepo
    }

    func getEvents() async throws -> [Event] {
        try eventsRepo.getEvents()
    }
}
