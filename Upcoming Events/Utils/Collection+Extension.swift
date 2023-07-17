//
//  Collection+Extension.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
