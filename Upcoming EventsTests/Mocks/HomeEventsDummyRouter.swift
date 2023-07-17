//
//  HomeEventsDummyRouter.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation
@testable import Upcoming_Events

final class HomeEventsDummyRouter: HomeEventsRouterProtocol {
    var showDetailsOfEventCalled: Int = 0
    var showErrorCalled: Int = 0

    func showDetails(of event: Event) {
        showDetailsOfEventCalled += 1
    }

    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void) {
        showErrorCalled += 1
    }
}
