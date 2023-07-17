//
//  GetImagesOfEventUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol GetImagesOfEventUseCase {
    func getImages() async throws -> [Data]
}
