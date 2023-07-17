//
//  FilterEventsUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol FilterEventsUseCase {
    func filter(events: [Event]) -> [EventSection]
}
