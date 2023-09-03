//
//  CategoriesPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import Foundation

protocol ICategoriesPresenter {
    func viewDidLoad()
    func playlistDidTap(with index: Int)
    var caterogy: Category { get }
    var categoriesPlaylistsResponse: CategoriesPlaylistsResponse? { get }
}

final class CategoriesPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoriesRouter
    private let spotifyService: Lazy<ISpotifyService>
    var categoriesPlaylistsResponse: CategoriesPlaylistsResponse?
    let caterogy: Category
    
    weak var view: ICategoriesView?
    
    // MARK: - Init
    
    init(router: ICategoriesRouter, spotifyService: Lazy<ISpotifyService>, caterogy: Category) {
        self.router = router
        self.spotifyService = spotifyService
        self.caterogy = caterogy
    }
    
    func viewDidLoad() {
        fetchCategoryPlaylist()
    }
    
    func playlistDidTap(with index: Int) {
        guard let playlist = categoriesPlaylistsResponse?.playlists.items[index] else { return }
        router.showPlaylistScreen(model: playlist)
    }
}
// MARK: - ICategoriesPresenter

private extension CategoriesPresenter {
    func fetchCategoryPlaylist() {
        
        spotifyService.get().getCategoryPlaylists(categoryID: caterogy.id, limit: 50) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let response):
                    self?.categoriesPlaylistsResponse = response
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
