//
//  EventSection.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

struct EventSection {
    let dayDate: Date
    var events: [EventWithConflicts]
}

struct EventWithConflicts {
    let event: Event
    let conflictsEvents: [Event]
}
