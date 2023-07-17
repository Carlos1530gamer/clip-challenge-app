//
//  EventTableViewCellConflictView.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

final class EventTableViewCellConflictView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }

    func configure(with event: Event) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "Conflict with: ",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 16)]))

        attributedText.append(NSAttributedString(string: event.title,
                                                 attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]))
        label.attributedText = attributedText
    }
}
