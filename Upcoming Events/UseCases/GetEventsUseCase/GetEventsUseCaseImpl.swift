//
//  GetEventsUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
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
