//
//  SaveImageOfEventUseCaseTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events
import XCTest

final class SaveImageOfEventUseCaseTests: XCTestCase {
    var sut: SaveImageOfEventUseCaseImpl!
    var repo: EventImagesRepositoryMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        repo = EventImagesRepositoryMock()
        sut = SaveImageOfEventUseCaseImpl(repository: repo)
    }

    func test_saveImage() async throws {
        // Given
        let image = UIImage(systemName: "star")
        guard let imageData = image?.pngData() else {
            XCTFail("Image data is nil")
            return
        }

        // When
        try await sut.saveImage(data: imageData, fileName: "sample")

        // Then
        XCTAssertTrue(repo.savedImages.contains(imageData))
    }
}
