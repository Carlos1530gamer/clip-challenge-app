//
//  EventImagesFileManagerRepositoryImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

final class EventImagesFileManagerRepositoryImpl: EventImagesRepository {
    private typealias Errors = EventImagesFileManagerRepositoryErrors
    private let fileManager: FileManager
    private let event: Event

    init(fileManager: FileManager = .default, event: Event) {
        self.fileManager = fileManager
        self.event = event
        createDirectory()
    }

    private func createDirectory() {
        do {
            let path = try makeDirectory(to: event)
            try fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func saveImage(data: Data, fileName: String) throws {
        let url = try makeDirectory(to: event)
        let fileUrl = url.appendingPathComponent(fileName).appendingPathExtension("png")
        try data.write(to: fileUrl)
    }

    func getImages() throws -> [Data] {
        let path = try makeDirectory(to: event)
        let items = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        return items.compactMap {
            try? Data(contentsOf: $0)
        }
    }

    func makeDirectory(to event: Event) throws -> URL {
        guard let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw Errors.cantGetPathOfDocuments
        }
        let relativePath = path.appendingPathComponent("images/\(event.title)/") // in this these case needs a persistand id to not coallition with another events
        return relativePath
    }
}
