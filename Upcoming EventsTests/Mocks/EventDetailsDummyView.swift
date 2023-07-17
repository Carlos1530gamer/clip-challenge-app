//
//  EventDetailsDummyView.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events

import Foundation

final class EventDetailsDummyView: NSObject {
    let viewModel: EventDetailsViewModelProtocol
    let input: EventDetailsViewInputProtocol

    init(viewModel: EventDetailsViewModelProtocol) {
        self.viewModel = viewModel
        self.input = viewModel
    }

    func viewLoaded() async {
        await viewModel.viewDidLoad()
    }

    func showCamera() {
        viewModel.showCamera(delegate: self)
    }

    func saveImage(data: Data) async {
        await viewModel.savePhoto(data: data)
    }
}

extension EventDetailsDummyView: CameraDelegate {}
