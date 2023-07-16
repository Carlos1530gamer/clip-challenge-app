//
//  Array+Extension.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

extension Array where Element == Event {
    mutating func toArrayGroupedBy(dateComponents: Set<Calendar.Component>) -> [[Element]] {
        var final: [[Element]] = []
        let dic = reduce(into: [Date: [Element]]()) { partialResult, element in
            // Create componets using contraints, i.e: day, month, year
            let components = Calendar.current.dateComponents(dateComponents, from: element.startDate)
            let date = Calendar.current.date(from: components)

            if let date = date {
                let existing = partialResult[date] ?? []
                partialResult[date] = (existing + [element])
            }
        } // the complexity of these are O(n) for the record each by each

        final = dic.sorted(by: { $0.key < $1.key }).map { $0.value } // Complexity O(n log n) for the map

        return final
    }

    mutating func toArrayGouped(by dateComponents: Set<Calendar.Component>) -> [EventSection] {
        sort(by: { $0.startDate < $1.startDate })
        var sections: [EventSection] = []

        for event in self {
            guard let eventExtractDate = try? getDate(from: dateComponents, in: event.startDate) else { continue }

            if var lastSection = sections.last { // Get the last section
                if let lastEventOfSection = lastSection.events.last { // Get the last event of the last section to compare
                    if lastSection.dayDate == eventExtractDate { // Are in the same group
                        if event.startDate <= lastEventOfSection.event.endDate { // Conflicts
                            lastSection.events.append(.init(event: event,
                                                            conflictsEvents: [
                                                                lastEventOfSection.event
                                                            ]))
                        } else { // No Conflicts
                            lastSection.events.append(.init(event: event, conflictsEvents: []))
                        }

                        sections[sections.count - 1] = lastSection

                    } else { // New Section
                        sections.append(.init(dayDate: eventExtractDate, events: [
                            .init(event: event, conflictsEvents: [])
                        ]))
                    }
                }

            } else { // Empty Case, put the first event
                sections.append(.init(dayDate: eventExtractDate, events: [
                    .init(event: event, conflictsEvents: [])
                ]))
            }
        }

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
