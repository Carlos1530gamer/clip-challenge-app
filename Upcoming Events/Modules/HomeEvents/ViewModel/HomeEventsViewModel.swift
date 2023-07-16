//
//  HomeEventsViewModel.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Foundation

protocol HomeEventsViewModelProtocol: HomeEventsViewInput {
    var getEventsUseCase: GetEventsUseCaseProtocol { get }
    var router: HomeEventsRouterProtocol { get }
    var view: HomeEventsViewProtocol? { get }

    func viewLoaded() async
    func select(event: Event)
}

final class HomeEventsViewModel: HomeEventsViewModelProtocol {
    // MARK: - View Inputs

    var events: [Event] = []
    var groupedEvents: [EventSection] {
        events.toArrayGouped(by: [.day, .month, .year])
    }

    // MARK: - Dependency Injection

    var getEventsUseCase: GetEventsUseCaseProtocol
    var router: HomeEventsRouterProtocol
    weak var view: HomeEventsViewProtocol?

    init(getEventsUseCase: GetEventsUseCaseProtocol, router: HomeEventsRouterProtocol) {
        self.getEventsUseCase = getEventsUseCase
        self.router = router
    }

    func viewLoaded() async {
        await fetchEvents()
    }

    @MainActor
    private func fetchEvents() async {
        do {
            try await getEvents()
            view?.reloadEvents()
        } catch {
            showError(subtitle: error.localizedDescription)
        }
    }

    private func getEvents() async throws {
        events = try await getEventsUseCase.getEvents()
    }

    func select(event: Event) {
        router.showDetails(of: event)
    }

    func showError(title: String = "Unknow Error", subtitle: String) {
        router.showError(title: title, subtitle: subtitle, acceptAction: { [weak self] in
            let safeSelf = self
            Task.detached {
                await safeSelf?.fetchEvents()
            }
        })
    }
}
