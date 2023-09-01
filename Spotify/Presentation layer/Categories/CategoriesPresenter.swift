//
//  CategoriesPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import Foundation

protocol ICategoriesPresenter {
    func viewDidLoad()
    var categoriesPlaylist: PlaylistDetailsResponse? { get }
}

final class CategoriesPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoriesRouter
    private let spotifyService: Lazy<ISpotifyService>
    
    private let model: Playlist
    var categoriesPlaylist: PlaylistDetailsResponse?

    
    weak var view: ICategoriesView?
    
    // MARK: - Init
    
    init(router: ICategoriesRouter, spotifyService: Lazy<ISpotifyService>, model: Playlist) {
        self.router = router
        self.spotifyService = spotifyService
        self.model = model
    }
    
    func viewDidLoad() {
        fetchCategoryPlaylist()
    }
}
// MARK: - ICategoriesPresenter
    
    private extension CategoriesPresenter {
        func fetchCategoryPlaylist() {
            spotifyService.get().getCategoryPlaylists(categoryID: model.id) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case.success(let response):
                        self?.categoriesPlaylist = response
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
