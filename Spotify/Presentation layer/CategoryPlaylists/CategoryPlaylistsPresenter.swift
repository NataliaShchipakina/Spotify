//
//  CategoryPlaylistsPresenter.swift
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

final class CategoryPlaylistsPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoryPlaylistsRouter
    private let spotifyService: Lazy<ISpotifyService>
    var categoriesPlaylistsResponse: CategoriesPlaylistsResponse?
    let caterogy: Category
    
    weak var view: ICategoryPlaylistsView?
    
    // MARK: - Init
    
    init(router: ICategoryPlaylistsRouter, spotifyService: Lazy<ISpotifyService>, caterogy: Category) {
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

private extension CategoryPlaylistsPresenter {
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
