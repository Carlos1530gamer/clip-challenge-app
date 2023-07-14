//
//  Event.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

struct Event: Codable {
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.comments = try container.decode(String.self, forKey: .comments)
        let startRawData = try container.decode(String.self, forKey: .startDate)
        let endRawData = try container.decode(String.self, forKey: .endDate)
        self.startDate = try startRawData.toDate(format: .getEventFormat)
        self.endDate = try endRawData.toDate(format: .getEventFormat)
    }
}
