//
//  GenericErrorViewController.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import SwiftUI
import UIKit

final class GenericErrorViewController: UIViewController {
    let modalTitle: String
    let subtitle: String
    let acceptAction: () -> Void

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String, subtitle: String, acceptAction: @escaping () -> Void) {
        self.modalTitle = title
        self.subtitle = subtitle
        self.acceptAction = acceptAction
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIHostingController(rootView: GenericErrorView(title: modalTitle,
                                                                subtitle: subtitle,
                                                                acceptAction: { [weak self] in
                                                                    self?.dismiss(animated: true)
                                                                    self?.acceptAction()
                                                                }))

        view.backgroundColor = .clear
        vc.view.backgroundColor = .clear
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        vc.didMove(toParent: self)
    }
}
