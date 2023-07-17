//
//  EventSection.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

struct EventSection: Equatable {
    let dayDate: Date
    var events: [EventWithConflict]
}

struct EventWithConflict: Equatable {
    let event: Event
    let conflictEvent: Event?
}
