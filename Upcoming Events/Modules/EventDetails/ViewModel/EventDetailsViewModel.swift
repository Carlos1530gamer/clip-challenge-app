//
//  EventDetailsViewModel.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation

protocol EventDetailsViewModelProtocol: EventDetailsViewInputProtocol {
    var router: EventDetailsRouterProtocol { get }
    var getImagesOfEventUseCase: GetImagesOfEventUseCase { get }
    var saveImageUseCase: SaveImageOfEventUseCase { get }
    var view: EventDetailsViewProtocol? { get set }

    func viewDidLoad() async
    func showCamera(delegate: CameraDelegate)
    func savePhoto(data: Data) async
}

final class EventDetailsViewModel: EventDetailsViewModelProtocol {
    // MARK: - Data Input to View

    var event: Event
    var imagesData: [Data] = []

    // MARK: - Depency Injection

    var router: EventDetailsRouterProtocol
    var getImagesOfEventUseCase: GetImagesOfEventUseCase
    var saveImageUseCase: SaveImageOfEventUseCase
    var view: EventDetailsViewProtocol?

    init(
        view: EventDetailsViewProtocol? = nil,
        event: Event,
        router: EventDetailsRouterProtocol,
        getImagesOfEventUseCase: GetImagesOfEventUseCase,
        saveImageUseCase: SaveImageOfEventUseCase)
    {
        self.view = view
        self.event = event
        self.router = router
        self.getImagesOfEventUseCase = getImagesOfEventUseCase
        self.saveImageUseCase = saveImageUseCase
    }

    func viewDidLoad() async {
        await getImages()
    }

    @MainActor
    private func getImages() async {
        do {
            let images = try await getImagesOfEventUseCase.getImages()
            imagesData = images
            view?.reloadImages()
        } catch {
            showError(subtitle: error.localizedDescription)
        }
    }

    func savePhoto(data: Data) async {
        do {
            try await saveImageUseCase.saveImage(data: data, fileName: UUID().uuidString)
            await getImages()
        } catch {
            showError(subtitle: error.localizedDescription)
        }
    }

    func showCamera(delegate: CameraDelegate) {
        router.showCamera(delegate: delegate)
    }

    func showError(title: String = "Unknow Error", subtitle: String) {
        router.showError(title: title, subtitle: subtitle, acceptAction: { [weak self] in
            let safetySelf = self
            Task.detached { @MainActor in
                await safetySelf?.getImages()
            }
        })
    }
}
