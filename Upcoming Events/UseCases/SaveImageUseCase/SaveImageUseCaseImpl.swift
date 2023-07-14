//
//  SaveImageUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

final class SaveImageUseCaseImpl: SaveImageUseCase {
    private let repository: EventImagesFileManagerRepository

    init(repository: EventImagesFileManagerRepository) {
        self.repository = repository
    }

    func saveImage(data: Data, fileName: String) async throws {
        try repository.saveImage(data: data, fileName: fileName)
    }
}
