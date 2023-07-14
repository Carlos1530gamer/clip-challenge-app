//
//  EventsRepository.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

enum EventsRepositoryErrors: Error {
    case cantGetData
}

protocol EventsRepositoryProtocol {
    func getEvents() throws -> [Event]
}
