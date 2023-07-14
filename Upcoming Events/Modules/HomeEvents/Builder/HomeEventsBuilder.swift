//
//  HomeEventsBuilder.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import UIKit

enum HomeEventsBuilder {
    static func build() -> HomeEventsViewController {
        let eventsRepo = EventsRepositoryLocalImpl()
        let getEventsUseCase = GetEventsUseCaseImpl(eventsRepo: eventsRepo)
        let router = HomeEventsRouter()
        let viewModel = HomeEventsViewModel(getEventsUseCase: getEventsUseCase,
                                            router: router)
        let viewController = HomeEventsViewController(viewModel: viewModel)
        router.baseViewController = viewController
        return viewController
    }
}
