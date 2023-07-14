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
}
