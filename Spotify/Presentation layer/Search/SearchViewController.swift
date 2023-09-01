//
//  SearchViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol ISearchView: AnyObject {
    func reloadData()
}

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    //    MARK: - UI
    
    private let searchController: UISearchController = {
        let results = UIViewController()
        results.view.backgroundColor = .red
        let searchVC = UISearchController(searchResultsController: SearchResultViewController())
        searchVC.searchBar.placeholder = "Songs, Artists, Albums"
        searchVC.searchBar.searchBarStyle = .minimal
        return searchVC
    }()
    
    // MARK: - CollectionView
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(150)),
                repeatingSubitem: item,
                count: 2
            )
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            return NSCollectionLayoutSection(group: group)
        }))
    
    // MARK: - Dependecies
    
    private let presenter: ISearchPresenter
    
    // MARK: - Init
    
    init(presenter: ISearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        setupUI()
        configureCollectionViewCell()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        collectionView.backgroundColor = .systemBackground
    }
    
    private func configureCollectionViewCell() {
        collectionView.register(
            GenreCollectionViewCell.self,
            forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
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
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        // resultsController.update(with: results)
        print(query)
        // Perform search
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GenreCollectionViewCell.identifier,
            for: indexPath
        ) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = presenter.categories!.categories.items[indexPath.row].name
        
        cell.configure(with: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.categories?.categories.items.count ?? 0
    }
}

extension SearchViewController: ISearchView {
    func reloadData() {
        collectionView.reloadData()
    }
}
