//
//  HomeEventsViewModel.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import Combine
import Foundation

protocol HomeEventsViewModelProtocol: HomeEventsViewInput {
    var getEventsUseCase: GetEventsUseCaseProtocol { get }
    var router: HomeEventsRouterProtocol { get }

    func viewLoaded() async
    func select(event: Event)
}

final class HomeEventsViewModel: HomeEventsViewModelProtocol {
    var getEventsUseCase: GetEventsUseCaseProtocol
    var router: HomeEventsRouterProtocol

    var events: [Event] = []
    var groupedEvents: [[Event]] {
        events.toArrayGroupedBy(dateComponents: [.day])
    }

    init(getEventsUseCase: GetEventsUseCaseProtocol, router: HomeEventsRouterProtocol) {
        self.getEventsUseCase = getEventsUseCase
        self.router = router
    }

    func viewLoaded() async {
        do {
            try await getEvents()
        } catch {
            print("Error: ", error.localizedDescription)
        }
    }

    func select(event: Event) {
        router.showDetails(of: event)
    }

    private func getEvents() async throws {
        events = try getEventsUseCase.getEvents()
    }
}
