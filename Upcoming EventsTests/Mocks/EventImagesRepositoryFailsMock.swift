//
//  EventImagesRepositoryFailsMock.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation
@testable import Upcoming_Events

final class EventImagesRepositoryFailsMock: EventImagesRepository {
    func saveImage(data: Data, fileName: String) throws {
        throw NSError(domain: "test", code: 0, userInfo: nil)
    }

    func getImages() throws -> [Data] {
        throw NSError(domain: "test", code: 0, userInfo: nil)
    }
}
