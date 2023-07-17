//
//  GetEventsUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol GetEventsUseCaseProtocol {
    func getEvents() async throws -> [Event]
}
