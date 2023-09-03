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
    var playlistDetailsResponse: PlaylistDetailsResponse? { get }
}

final class CategoriesPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoriesRouter
    private let spotifyService: Lazy<ISpotifyService>
    var playlistDetailsResponse: PlaylistDetailsResponse?
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
        guard let model = playlistDetailsResponse?.tracks.items[index] else { return }
//        router.showPlaylistScreen(model: <#T##Playlist#>)
    }
}
// MARK: - ICategoriesPresenter

private extension CategoriesPresenter {
    func fetchCategoryPlaylist() {
        
        spotifyService.get().getCategoryPlaylists(categoryID: caterogy.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let response):
                    self?.playlistDetailsResponse = response
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
