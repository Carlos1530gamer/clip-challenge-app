//
//  GetImagesOfEventUseCaseImpl.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
import UIKit.UIImage

final class GetImagesOfEventUseCaseImpl: GetImagesOfEventUseCase {
    private let repository: EventImagesFileManagerRepository

    init(repository: EventImagesFileManagerRepository) {
        self.repository = repository
    }

    func getImages() async throws -> [UIImage] {
        try repository.getImages()
    }
}
