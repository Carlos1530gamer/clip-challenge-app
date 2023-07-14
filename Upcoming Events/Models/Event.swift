//
//  Event.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

struct Event: Codable, Equatable {
    let title: String
    let comments: String
    let startDate: Date
    let endDate: Date

    enum CodingKeys: String, CodingKey {
        case title
        case comments
        case startDate = "start"
        case endDate = "end"
    }

    public init(title: String, comments: String, startDate: Date, endDate: Date) {
        self.title = title
        self.comments = comments
        self.startDate = startDate
        self.endDate = endDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.comments = try container.decode(String.self, forKey: .comments)
        let startRawData = try container.decode(String.self, forKey: .startDate)
        let endRawData = try container.decode(String.self, forKey: .endDate)
        let formatter = CustomDateFormat.getEventFormat
        self.startDate = try formatter.date(from: startRawData)
        self.endDate = try formatter.date(from: endRawData)
    }
}
