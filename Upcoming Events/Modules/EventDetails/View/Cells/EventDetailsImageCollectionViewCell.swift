//
//  EventDetailsImageCollectionViewCell.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

final class EventDetailsImageCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with imageData: Data) {
        imageView.image = UIImage(data: imageData)
        imageView.layer.cornerRadius = bounds.height / 10
    }
}
