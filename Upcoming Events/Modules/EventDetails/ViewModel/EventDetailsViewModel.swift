//
//  EventDetailsViewModel.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import Foundation
import UIKit

protocol EventDetailsViewModelProtocol: EventDetailsViewInputProtocol {
    var router: EventDetailsRouterProtocol { get }
    var getImagesOfEventUseCase: GetImagesOfEventUseCase { get }
    var saveImageUseCase: SaveImageUseCase { get }
    var view: EventDetailsViewProtocol? { get set }

    func viewDidLoad() async
    func showCamera(delegate: CameraDelegate)
    func savePhoto(data: Data) async
}

final class EventDetailsViewModel: EventDetailsViewModelProtocol {
    var event: Event
    var images: [UIImage] = []
    var router: EventDetailsRouterProtocol
    var getImagesOfEventUseCase: GetImagesOfEventUseCase
    var saveImageUseCase: SaveImageUseCase
    var view: EventDetailsViewProtocol?

    init(
        event: Event,
        router: EventDetailsRouterProtocol,
        getImagesOfEventUseCase: GetImagesOfEventUseCase,
        saveImageUseCase: SaveImageUseCase)
    {
        self.event = event
        self.router = router
        self.getImagesOfEventUseCase = getImagesOfEventUseCase
        self.saveImageUseCase = saveImageUseCase
    }

    func viewDidLoad() async {
        await getImages()
    }

    @MainActor
    func getImages() async {
        do {
            let images = try await getImagesOfEventUseCase.getImages()
            self.images = images
            view?.reloadImages()
        } catch {
            print(error.localizedDescription)
        }
    }

    func showCamera(delegate: CameraDelegate) {
        router.showCamera(delegate: delegate)
    }

    @MainActor
    func savePhoto(data: Data) async {
        do {
            try await saveImageUseCase.saveImage(data: data, fileName: UUID().uuidString)
            await getImages()
        } catch {
            print(error.localizedDescription)
        }
    }
}
