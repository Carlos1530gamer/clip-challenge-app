//
//  HomeEventsBuilder.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

enum HomeEventsBuilder {
    static func build() -> HomeEventsViewController {
        let eventsRepo = EventsRepositoryLocalImpl()
        let getEventsUseCase = GetEventsUseCaseImpl(eventsRepo: eventsRepo)
        let filterEventsUseCase = FilterEventsUseCaseImpl()

        let router = HomeEventsRouter()
        let viewModel = HomeEventsViewModel(getEventsUseCase: getEventsUseCase,
                                            filterEventsUseCase: filterEventsUseCase,
                                            router: router)
        let viewController = HomeEventsViewController(viewModel: viewModel)
        router.baseViewController = viewController
        viewModel.view = viewController
        return viewController
    }
}
