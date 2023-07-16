//
//  EventTableViewCell.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
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

    private var cardView: CardView = {
        let view = CardView()
        view.backgroundColor = .generateRandomPastelColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var timeRangeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.numberOfLines = 1
        view.font = .italicSystemFont(ofSize: 12)
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
        cardView.addSubview(titleLabel)
        cardView.addSubview(timeRangeLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            timeRangeLabel.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor),
            timeRangeLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -6),
            timeRangeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.leadingAnchor),
            timeRangeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -6),
        ])
    }

    func configure(with event: EventWithConflicts) {
        let dateFormatter = CustomDateFormat.onlyHour12
        titleLabel.text = event.event.title
        timeRangeLabel.text = String(format: "%@ - %@",
                                     dateFormatter.string(from: event.event.startDate),
                                     dateFormatter.string(from: event.event.endDate))
    }
}
