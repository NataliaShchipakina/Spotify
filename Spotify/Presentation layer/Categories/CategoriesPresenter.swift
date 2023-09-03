//
//  CategoriesPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import Foundation

protocol ICategoriesPresenter {
    func viewDidLoad()
    func didTapCategory(indexRow: Int)
    var categories: AllCategoriesResponse? { get }
}

final class CategoriesPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoriesRouter
    private let spotifyService: Lazy<ISpotifyService>
    
    var categories: AllCategoriesResponse?
    
    weak var view: ICategoriesView?
    
    // MARK: - Init
    
    init(router: ICategoriesRouter, spotifyService: Lazy<ISpotifyService>) {
        self.router = router
        self.spotifyService = spotifyService
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func didTapCategory(indexRow: Int) {
        guard let model = categories?.categories.items[indexRow] else { return }
        router.showCategoriesScreen(categories: model)
    }
}
// MARK: - ICategoriesPresenter

private extension CategoriesPresenter {
    func fetchCategories() {
        spotifyService.get().getCategories(limit: 50) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let response):
                    self?.categories = response
                    self?.view?.reloadData()
                case .failure(let error):
                    preconditionFailure("error come")
                }
            }
        }
    }
}


