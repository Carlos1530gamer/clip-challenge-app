//
//  HomeEventsRouter.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

protocol HomeEventsRouterProtocol {
    func showDetails(of event: Event)
    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void)
}

final class HomeEventsRouter: HomeEventsRouterProtocol {
    weak var baseViewController: UIViewController?
    private var navigation: UINavigationController? {
        baseViewController?.navigationController
    }

    init(baseViewController: UIViewController? = nil) {
        self.baseViewController = navigation
    }

    func showDetails(of event: Event) {
        let detailView = EventDetailsBuilder.build(event: event, navigation: navigation)
        navigation?.pushViewController(detailView, animated: true)
    }

    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void) {
        let errorVC = GenericErrorViewController(title: title,
                                                 subtitle: subtitle,
                                                 acceptAction: acceptAction)
        errorVC.modalPresentationStyle = .overFullScreen
        navigation?.present(errorVC, animated: true)
    }
}
