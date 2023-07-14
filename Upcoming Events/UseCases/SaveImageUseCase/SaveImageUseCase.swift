//
//  SaveImageUseCase.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation

protocol SaveImageUseCase {
    func saveImage(data: Data, fileName: String) async throws
}
