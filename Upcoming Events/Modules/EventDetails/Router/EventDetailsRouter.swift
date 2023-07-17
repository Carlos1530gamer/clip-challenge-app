//
//  EventDetailsRouter.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

typealias CameraDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

protocol EventDetailsRouterProtocol {
    func showCamera(delegate: CameraDelegate)
    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void)
}

final class EventDetailsRouter: EventDetailsRouterProtocol {
    private weak var navigation: UINavigationController?

    init(navigation: UINavigationController?) {
        self.navigation = navigation
    }

    func showCamera(delegate: CameraDelegate) {
        let picker = UIImagePickerController()
        picker.modalPresentationStyle = .fullScreen
        #if targetEnvironment(simulator) // Code to show library when is simulator or camera in real device
            picker.sourceType = .photoLibrary
        #else
            picker.sourceType = .camera
        #endif
        picker.allowsEditing = true
        picker.delegate = delegate
        navigation?.present(picker, animated: true)
    }

    func showError(title: String, subtitle: String, acceptAction: @escaping () -> Void) {
        let errorVC = GenericErrorViewController(title: title,
                                                 subtitle: subtitle,
                                                 acceptAction: acceptAction)
        errorVC.modalPresentationStyle = .overFullScreen
        navigation?.present(errorVC, animated: true)
    }
}
