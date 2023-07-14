//
//  GetEventsUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

protocol GetEventsUseCaseProtocol {
    func getEvents() throws -> [Event]
}
