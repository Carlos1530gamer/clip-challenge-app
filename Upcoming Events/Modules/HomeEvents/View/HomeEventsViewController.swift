//
//  HomeEventsViewController.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 13/07/23.
//

import UIKit

protocol HomeEventsViewProtocol: AnyObject {
    func reloadEvents()
}

protocol HomeEventsViewInput {
    var events: [Event] { get }
    var groupedEvents: [EventSection] { get }
}

final class HomeEventsViewController: UIViewController {
    private let input: HomeEventsViewInput
    private let viewModel: HomeEventsViewModelProtocol
    private var task: Task<Void, Error>?

    private var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: HomeEventsViewModelProtocol) {
        self.input = viewModel
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }

    deinit {
        task?.cancel() // To liberate memory
        task = nil
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        task = Task.detached {
            await self.viewModel.viewLoaded()
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupTableView()
    }

    private func setupNavigation() {
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Handle Events of ViewModel

extension HomeEventsViewController: HomeEventsViewProtocol {
    func reloadEvents() {
        tableView.reloadData()
    }
}

// MARK: - Delegate and Sourcing of Collection

extension HomeEventsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        input.groupedEvents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        input.groupedEvents[safe: section]?.events.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = input.groupedEvents[safe: section] else { return nil }
        return CustomDateFormat.day.string(from: section.dayDate)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? EventTableViewCell,
            let event = input.groupedEvents[safe: indexPath.section]?.events[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: event)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let eventWithConflicts = input.groupedEvents[safe: indexPath.section]?.events[safe: indexPath.row] else { return }
        viewModel.select(event: eventWithConflicts.event)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
