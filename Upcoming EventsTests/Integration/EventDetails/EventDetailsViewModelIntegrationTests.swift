//
//  EventDetailsViewModelIntegrationTests.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events
import XCTest

final class EventDetailsViewModelIntegrationTests: XCTestCase {
    private var event: Event!
    private var sut: EventDetailsViewModel!
    private var dummyRouter: EventDetailsDummyRouter!
    private var dummyView: EventDetailsDummyView!
    private var imagesRepo: EventImagesRepository!

    override func setUpWithError() throws {
        continueAfterFailure = false
        event = .init(title: "title 1",
                      comments: "commnets 1",
                      startDate: Date(timeIntervalSince1970: 1541872800),
                      endDate: Date(timeIntervalSince1970: 1541876400))
        dummyRouter = EventDetailsDummyRouter()
        imagesRepo = EventImagesRepositoryMock()
        sut = .init(event: event,
                    router: dummyRouter,
                    getImagesOfEventUseCase: GetImagesOfEventUseCaseImpl(repository: imagesRepo),
                    saveImageUseCase: SaveImageOfEventUseCaseImpl(repository: imagesRepo))
        dummyView = EventDetailsDummyView(viewModel: sut)
    }

    func test_getAllImagesToView() async throws {
        // Given
        let image = UIImage(systemName: "star")
        guard let imageData = image?.pngData() else {
            XCTFail("Image data is nil")
            return
        }
        try imagesRepo.saveImage(data: imageData, fileName: "star")

        // When
        await dummyView.viewLoaded()

        // Then
        XCTAssertEqual(dummyView.input.imagesData, [imageData])
    }

    func test_saveImageCorrectly() async {
        // Given
        let image = UIImage(systemName: "star")
        guard let imageData = image?.pngData() else {
            XCTFail("Image data is nil")
            return
        }

        // When
        await dummyView.saveImage(data: imageData)

        // Then
        XCTAssertTrue(try imagesRepo.getImages().contains(imageData))
    }

    func test_showCamera() {
        // When
        dummyView.showCamera()

        // Then
        XCTAssertEqual(dummyRouter.showCameraCalled, 1)
    }

    func test_showError() async {
        // Given
        imagesRepo = EventImagesRepositoryFailsMock()
        sut = .init(event: event,
                    router: dummyRouter,
                    getImagesOfEventUseCase: GetImagesOfEventUseCaseImpl(repository: imagesRepo),
                    saveImageUseCase: SaveImageOfEventUseCaseImpl(repository: imagesRepo))
        dummyView = .init(viewModel: sut)

        // When
        await dummyView.viewLoaded()
        await dummyView.saveImage(data: Data())

        // Then
        XCTAssertEqual(dummyRouter.showErrorCalled, 2)
    }
}
