//
//  EventsRepository.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

enum EventsRepositoryErrors: Error {
    case cantGetData
}

protocol EventsRepositoryProtocol {
    func getEvents() throws -> [Event]
}
