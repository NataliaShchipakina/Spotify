//
//  ViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol IHomeView: AnyObject {
    func reloadData()
}

enum BrowseSectionType {
    case newReleases(viewModels: [NewReleasesCellModel])
    case featuredPlaylists(viewModels: [NewReleasesCellModel])
    case recommendedTracks(viewModels: [NewReleasesCellModel])
}

class HomeViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let presenter: IHomePresenter
    private let layoutProvider: IHomeCollectionViewLayout
    
    // MARK: - Init
    
    init(presenter: IHomePresenter, layoutProvider: IHomeCollectionViewLayout) {
        self.presenter = presenter
        self.layoutProvider = layoutProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView
    
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ -> NSCollectionLayoutSection? in
            self?.layoutProvider.createSectionLayout(section: sectionIndex)
        }
    )
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
        configureCollectionView()
        view.addSubview(spinner)
    }
    
    private func setupUI() {
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.register(
            NewReleaseCollectionViewCell.self,
            forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier
        )
        collectionView.register(
            FeaturedPlaylistCollectionViewCell.self,
            forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier
        )
        collectionView.register(
            RecommendedTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
    }
    
    @objc func didTapSettings() {
        presenter.didTapSettingsButton()
    }
}

// MARK: - IHomeView

extension HomeViewController: IHomeView {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.sections.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = presenter.sections[section]
        switch type {
        case .newReleases(let viewModels):
            return viewModels.count
        case .featuredPlaylists(let viewModels):
            return viewModels.count
        case .recommendedTracks(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = presenter.sections[indexPath.section]
        switch type {
        case .newReleases(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                for: indexPath
            ) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        case .featuredPlaylists(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
                for: indexPath
            ) as? FeaturedPlaylistCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .blue
            return cell
        case .recommendedTracks(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier,
                for: indexPath
            ) as? RecommendedTrackCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .orange
            return cell
            
        }
    }
    
}
