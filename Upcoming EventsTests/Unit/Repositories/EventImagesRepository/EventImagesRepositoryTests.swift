//
//  EventImagesRepositoryTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events

import XCTest

final class EventImagesRepositoryTests: XCTestCase {
    var fileManager = FileManager()
    var sut: EventImagesFileManagerRepositoryImpl!
    var event: Event?

    override func setUpWithError() throws {
        continueAfterFailure = false
        let event = Event(title: "SomeTitle",
                          comments: "SomeComments",
                          startDate: Date(timeIntervalSince1970: 1541872800),
                          endDate: Date(timeIntervalSince1970: 1541876400))
        fileManager = FileManager()
        sut = EventImagesFileManagerRepositoryImpl(fileManager: fileManager, event: event)
        self.event = event
    }

    func test_saveAndRetriveImage() throws {
        // Given
        guard let imageData = UIImage(systemName: "star")?.pngData() else {
            XCTFail("The image should not be nil")
            return
        }

        // When
        try sut.saveImage(data: imageData, fileName: "star")

        // Then
        XCTAssertTrue(try sut.getImages().contains(imageData))
    }
}
