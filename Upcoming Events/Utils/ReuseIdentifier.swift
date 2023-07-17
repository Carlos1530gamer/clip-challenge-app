//
//  ReuseIdentifier.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol ReuseIdentifier {}
extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
