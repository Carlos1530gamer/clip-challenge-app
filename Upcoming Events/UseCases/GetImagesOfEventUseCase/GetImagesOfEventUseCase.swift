//
//  GetImagesOfEventUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
import UIKit.UIImage

protocol GetImagesOfEventUseCase {
    func getImages() async throws -> [UIImage]
}
