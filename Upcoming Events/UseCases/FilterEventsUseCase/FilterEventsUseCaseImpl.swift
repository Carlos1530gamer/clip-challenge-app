//
//  FilterEventsUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

final class FilterEventsUseCaseImpl: FilterEventsUseCase {
    func filter(events: [Event]) -> [EventSection] {
        var events = events
        events.sort(by: { $0.startDate < $1.startDate }) // The complexity of sorted func swift are O(n log n) in the best cases
        var sections: [EventSection] = []

        for event in events {
            guard let eventExtractDate = try? getDate(from: [.day, .month, .year], in: event.startDate) else { continue } // fragment the date only extracting the day, month and year to compare these elements on each iteration and group using these elements

            if var lastSection = sections.last { // Get the last section
                if let lastEventOfSection = lastSection.events.last { // Get the last event of the last section to compare
                    if lastSection.dayDate == eventExtractDate { // Are in the same group
                        if event.startDate < lastEventOfSection.event.endDate { // Have Conflicts
                            lastSection.events.append(.init(event: event,
                                                            conflictEvent: lastEventOfSection.event))
                        } else { // No Conflicts
                            lastSection.events.append(.init(event: event, conflictEvent: nil))
                        }

                        sections[sections.count - 1] = lastSection

                    } else { // New Section
                        sections.append(.init(dayDate: eventExtractDate, events: [
                            .init(event: event, conflictEvent: nil)
                        ]))
                    }
                }

            } else { // Empty Case, put the first section and event
                sections.append(.init(dayDate: eventExtractDate, events: [
                    .init(event: event, conflictEvent: nil)
                ]))
            }
        }

        // Only use one iteration these solution the complexity of these are O(n) in all cases(best and worst)

        return sections
    }

    private func getDate(from components: Set<Calendar.Component>, in date: Date) throws -> Date {
        let components = Calendar.current.dateComponents(components, from: date)
        guard let date = Calendar.current.date(from: components) else {
            throw NSError(domain: "Error creating date", code: 0, userInfo: nil)
        }
        return date
    }
}
