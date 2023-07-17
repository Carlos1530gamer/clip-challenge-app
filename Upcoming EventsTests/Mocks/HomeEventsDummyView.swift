//
//  HomeEventsDummyView.swift
//  Upcoming EventsTests
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

@testable import Upcoming_Events

import Foundation

struct HomeEventsDummyView {
    let viewModel: HomeEventsViewModelProtocol
    let input: HomeEventsViewInput

    init(viewModel: HomeEventsViewModelProtocol) {
        self.viewModel = viewModel
        self.input = viewModel
    }
}
