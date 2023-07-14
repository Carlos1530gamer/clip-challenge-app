//
//  EventImagesRepositoryMock.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
@testable import Upcoming_Events

final class EventImagesRepositoryMock: EventImagesRepository {
    var savedImages: Set<Data> = []

    func saveImage(data: Data, fileName: String) throws {
        savedImages.insert(data)
    }

    func getImages() throws -> [Data] {
        savedImages.map { $0 }
    }
}
