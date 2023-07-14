//
//  HomeEventsRouter.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import UIKit

protocol HomeEventsRouterProtocol {
    var baseViewController: UIViewController? { set get }
    func showDetails(of event: Event)
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
}
