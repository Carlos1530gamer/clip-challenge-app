//
//  GetImagesOfEventUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

final class GetImagesOfEventUseCaseImpl: GetImagesOfEventUseCase {
    private let repository: EventImagesRepository

    init(repository: EventImagesRepository) {
        self.repository = repository
    }

    func getImages() async throws -> [Data] {
        try repository.getImages()
    }
}
