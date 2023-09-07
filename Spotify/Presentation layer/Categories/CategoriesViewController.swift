//
//  CategoriesViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol ICategoriesView: AnyObject {
    func reloadData()
}

class CategoriesViewController: UIViewController, UISearchResultsUpdating {
    
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
    
    private let presenter: ICategoriesPresenter
    private var categories = [Category]()
    
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
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
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
        print(query)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = presenter.categories!.categories.items[indexPath.row].name
        let imageURL = presenter.categories!.categories.items[indexPath.row].icons.first?.url
        guard let url = URL(optionalString: imageURL) else { fatalError() }
        cell.configure(with: title, imageURL: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.categories?.categories.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didTapCategory(indexRow: indexPath.row)
    }
}

extension CategoriesViewController: ICategoriesView {
    func reloadData() {
        collectionView.reloadData()
    }
}
