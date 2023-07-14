//
//  EventDetailsBuilder.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import UIKit

enum EventDetailsBuilder {
    static func build(event: Event, navigation: UINavigationController?) -> EventDetailsViewController {
        let router = EventDetailsRouter(navigation: navigation)
        let imagesFileManagerRepository = EventImagesFileManagerRepositoryImpl(event: event)
        let saveImageUseCase = SaveImageOfEventUseCaseImpl(repository: imagesFileManagerRepository)
        let getImagesOfEventUseCase = GetImagesOfEventUseCaseImpl(repository: imagesFileManagerRepository)
        let viewModel = EventDetailsViewModel(event: event,
                                              router: router,
                                              getImagesOfEventUseCase: getImagesOfEventUseCase,
                                              saveImageUseCase: saveImageUseCase)
        let viewController = EventDetailsViewController(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}
