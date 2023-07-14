//
//  GetImagesOfEventUseCaseTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

@testable import Upcoming_Events
import XCTest

final class GetImagesOfEventUseCaseTests: XCTestCase {
    var sut: GetImagesOfEventUseCase!
    var repository: EventImagesRepositoryMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        repository = EventImagesRepositoryMock()
        sut = GetImagesOfEventUseCaseImpl(repository: repository)
    }

    func test_getImagesEmpty() async throws {
        // When
        let images = try await sut.getImages()

        // Then
        XCTAssertTrue(images.isEmpty)
    }

    func test_getImages() async throws {
        // Given
        let image = UIImage(systemName: "star")
        guard let imageData = image?.pngData() else {
            XCTFail("Image data is nil")
            return
        }
        try repository.saveImage(data: imageData, fileName: "star")

        // When
        let images = try await sut.getImages()

        // Then
        XCTAssertEqual(images, [imageData])
    }
}
