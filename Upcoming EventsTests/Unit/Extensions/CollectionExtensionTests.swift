//
//  CollectionExtensionTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events
import XCTest

final class CollectionExtensionTests: XCTestCase {
    func test_safeAccess() {
        // Given
        let array = ["a", "b", "c"]

        // When
        let existingResul = array[safe: 1]
        let nonExistingResult = array[safe: 3]

        // Then
        XCTAssertEqual(existingResul, "b")
        XCTAssertNil(nonExistingResult)
    }
}
