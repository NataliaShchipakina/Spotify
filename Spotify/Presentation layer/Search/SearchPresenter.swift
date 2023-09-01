//
//  SearchPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import Foundation

protocol ISearchPresenter {
    func viewDidLoad()
    var categories: AllCategoriesResponse? { get }
}

final class SearchPresenter: ISearchPresenter {
    
    // MARK: - Dependencies
    
    private let router: ISearchRouter
    private let spotifyService: Lazy<ISpotifyService>
    
    var categories: AllCategoriesResponse?
    
    weak var view: ISearchView?
    
    // MARK: - Init
    
    init(router: ISearchRouter, spotifyService: Lazy<ISpotifyService>) {
        self.router = router
        self.spotifyService = spotifyService
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        fetchCategories()
    }
    
}
// MARK: - ISearchPresenter

private extension SearchPresenter {
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


