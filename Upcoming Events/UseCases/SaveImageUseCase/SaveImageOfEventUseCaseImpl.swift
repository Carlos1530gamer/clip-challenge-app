//
//  SaveImageOfEventUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

final class SaveImageOfEventUseCaseImpl: SaveImageOfEventUseCase {
    private let repository: EventImagesRepository

    init(repository: EventImagesRepository) {
        self.repository = repository
    }

    func saveImage(data: Data, fileName: String) async throws {
        try repository.saveImage(data: data, fileName: fileName)
    }
}
