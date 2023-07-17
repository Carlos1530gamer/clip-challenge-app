//
//  EventDetailsDummyRouter.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import Foundation
@testable import Upcoming_Events

final class EventDetailsDummyRouter: EventDetailsRouterProtocol {
    var showCameraCalled: Int = 0
    var showErrorCalled: Int = 0

    func showCamera(delegate: CameraDelegate) {
        showCameraCalled += 1
    }

    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void) {
        showErrorCalled += 1
    }
}
