//
//  CategoryPlaylistsViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoryPlaylistsView: AnyObject {
    func reloadData()
}

final class CategoryPlaylistsViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let presenter: ICategoriesPresenter
    
    // MARK: - CollectionView
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(250)
                ),
                repeatingSubitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        })
    )
    
    // MARK: - Init
    
    init(presenter: ICategoriesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionViewCell()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = presenter.caterogy.name
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    private func configureCollectionViewCell() {
        view.addSubview(collectionView)
        
        collectionView.register(
            FeaturedPlaylistCollectionViewCell.self,
            forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ICategoriesView

extension CategoryPlaylistsViewController: ICategoryPlaylistsView {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension CategoryPlaylistsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.categoriesPlaylistsResponse?.playlists.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
                for: indexPath) as? FeaturedPlaylistCollectionViewCell,
            let playlist = presenter.categoriesPlaylistsResponse?.playlists.items[indexPath.row]
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: FeaturedPlaylistCellModel(
            name: playlist.name,
            artworkURL: URL(optionalString: playlist.images.first?.url),
            creatorName: playlist.owner.displayName
        ))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.playlistDidTap(with: indexPath.row)
    }
}
