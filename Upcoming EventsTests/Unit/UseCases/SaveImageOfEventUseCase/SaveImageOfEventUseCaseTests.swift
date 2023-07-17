//
//  SaveImageOfEventUseCaseTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class SaveImageOfEventUseCaseTests: XCTestCase {
    private var sut: SaveImageOfEventUseCaseImpl!
    private var repo: EventImagesRepositoryMock!

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
