//
//  AlbumDetailsPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import Foundation

protocol IAlbumPresenter {
    func viewDidLoad()
}

final class AlbumDetailsPresenter: IAlbumPresenter {
    
    // MARK: - Dependencies
    
    private let router: IAlbumRouter
    private let spotifyService: Lazy<ISpotifyService>
    private let model: Album
    
    weak var view: IAlbumView?
    
    // MARK: - Init
    
    init(router: IAlbumRouter, spotifyService: Lazy<ISpotifyService>, model: Album) {
        self.router = router
        self.spotifyService = spotifyService
        self.model = model
        
    }
    
    // MARK: -
    func viewDidLoad() {
        fetchAlbumDetails()
    }
}

private extension AlbumDetailsPresenter {
    func fetchAlbumDetails() {
        spotifyService.get().getAlbumDetails(albumID: model.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self?.view?.configure(with: model)
                case .failure(let error):
                    print("Пришла ошибка на запрос getPlaylistDetails: \(error.localizedDescription)")
                }
            }
        }
    }
}

