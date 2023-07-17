//
//  EventImagesRepository.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

enum EventImagesFileManagerRepositoryErrors: Error {
    case cantGetPathOfDocuments
}

protocol EventImagesRepository {
    func saveImage(data: Data, fileName: String) throws
    func getImages() throws -> [Data]
}
