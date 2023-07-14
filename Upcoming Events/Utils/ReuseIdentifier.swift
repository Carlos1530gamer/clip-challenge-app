//
//  ReuseIdentifier.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

protocol ReuseIdentifier {}
extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
