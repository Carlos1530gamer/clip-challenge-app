//
//  SaveImageOfEventUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol SaveImageOfEventUseCase {
    func saveImage(data: Data, fileName: String) async throws
}
