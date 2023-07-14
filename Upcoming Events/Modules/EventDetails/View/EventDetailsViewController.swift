//
//  EventDetailsViewController.swift
//  Upcoming Events
//
//  Created by Carlos Daniel Hernandez Chauteco on 14/07/23.
//

import UIKit

protocol EventDetailsViewProtocol {
    func reloadImages()
}

protocol EventDetailsViewInputProtocol {
    var event: Event { get }
    var imagesData: [Data] { get }
}

final class EventDetailsViewController: UIViewController {
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private let takePhotoButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Take Picture", for: .normal)
        return button
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private let input: EventDetailsViewInputProtocol
    private let viewModel: EventDetailsViewModelProtocol

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: EventDetailsViewModelProtocol) {
        self.input = viewModel
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupLayout()
        setupCollectionView()
        bindData()

        Task.detached { @MainActor in
            await self.viewModel.viewDidLoad()
        }
    }

    private func bindData() {
        dateLabel.text = input.event.startDate.toFormatedString(format: .day)
        descriptionLabel.text = input.event.comments
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            EventDetailsImageCollectionViewCell.self,
            forCellWithReuseIdentifier: EventDetailsImageCollectionViewCell.reuseIdentifier
        )
    }

    private func setupNavigation() {
        navigationItem.title = input.event.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupLayout() {
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(takePhotoButton)
        view.addSubview(collectionView)

        // Handle interactions
        takePhotoButton.addTarget(self, action: #selector(showCamera), for: .touchUpInside)

        // Configure label constraints
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor, constant: -10),

            takePhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            takePhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            takePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    // MARK: - Button Actions

    @objc private func showCamera() {
        viewModel.showCamera(delegate: self)
    }
}

extension EventDetailsViewController: EventDetailsViewProtocol {
    func reloadImages() {
        collectionView.reloadData()
    }
}

extension EventDetailsViewController: CameraDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage,
              let data = image.pngData() else { return }
        Task.detached(operation: { @MainActor in await self.viewModel.savePhoto(data: data) })
        picker.dismiss(animated: true)
    }
}

extension EventDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        input.imagesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: EventDetailsImageCollectionViewCell.reuseIdentifier, for: indexPath) as? EventDetailsImageCollectionViewCell,
            let data = input.imagesData[safe: indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: data)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width, height: bounds.height)
    }
}
