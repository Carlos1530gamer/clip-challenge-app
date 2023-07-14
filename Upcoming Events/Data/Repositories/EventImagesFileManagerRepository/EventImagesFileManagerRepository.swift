//
//  EventImagesFileManagerRepository.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
import UIKit.UIImage

enum EventImagesFileManagerRepositoryErrors: Error {
    case cantGetPathOfDocuments
}

protocol EventImagesFileManagerRepository {
    func saveImage(data: Data, fileName: String) throws
    func getImages() throws -> [UIImage]
}
