//
//  EventTableViewCell.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco.
//

import UIKit

final class EventTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.numberOfLines = .zero
        return view
    }()

    private let cardView: CardView = {
        let view = CardView()
        view.backgroundColor = .generateRandomPastelColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()

    private let eventView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let timeRangeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.numberOfLines = 1
        view.font = .italicSystemFont(ofSize: 12)
        return view
    }()

    private lazy var conflictView: EventTableViewCellConflictView = {
        let view = EventTableViewCellConflictView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.cornerRadius = cardView.frame.height / 8
    }

    private func setupLayout() {
        addSubview(cardView)
        cardView.addSubview(stackView)
        eventView.addSubview(titleLabel)
        eventView.addSubview(timeRangeLabel)
        stackView.addArrangedSubview(eventView)
        stackView.addArrangedSubview(conflictView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: eventView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: eventView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: eventView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: eventView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])

        NSLayoutConstraint.activate([
            timeRangeLabel.topAnchor.constraint(greaterThanOrEqualTo: eventView.topAnchor),
            timeRangeLabel.bottomAnchor.constraint(equalTo: eventView.bottomAnchor, constant: -6),
            timeRangeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: eventView.leadingAnchor),
            timeRangeLabel.trailingAnchor.constraint(equalTo: eventView.trailingAnchor, constant: -6),
        ])
    }

    func configure(with event: EventWithConflict) {
        let dateFormatter = CustomDateFormat.onlyHour12
        titleLabel.text = event.event.title
        timeRangeLabel.text = String(format: "%@ - %@",
                                     dateFormatter.string(from: event.event.startDate),
                                     dateFormatter.string(from: event.event.endDate))

        if let conlict = event.conflictEvent {
            conflictView.isHidden = false
            conflictView.configure(with: conlict)
        } else {
            conflictView.isHidden = true
        }
    }
}
