//
//  GetImagesOfEventUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

protocol GetImagesOfEventUseCase {
    func getImages() async throws -> [Data]
}
