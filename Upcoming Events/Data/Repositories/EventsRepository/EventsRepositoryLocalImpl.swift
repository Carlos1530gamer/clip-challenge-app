//
//  EventsRepositoryLocalImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

final class EventsRepositoryLocalImpl: EventsRepositoryProtocol {
    func getEvents() throws -> [Event] {
        guard let bundlePath = Bundle.main.path(forResource: "mock", ofType: "json") else {
            throw EventsRepositoryErrors.cantGetData
        }
        let jsonData = try Data(contentsOf: URL(filePath: bundlePath), options: .mappedIfSafe)
        return try JSONDecoder().decode([Event].self, from: jsonData)
    }
}
