//
//  PlaylistPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import Foundation

protocol IPlaylistPresenter {
    var viewModels: [RecommendedTrackCellModel] { get }
    func viewDidLoad()
}

final class PlaylistPresenter: IPlaylistPresenter {
    
    // MARK: - Dependencies
    
    private let router: IPlaylistRouter
    private let spotifyService: ISpotifyService
    private let model: Playlist
    
    weak var view: IPlaylistView?
    
    // MARK: - Init
    
    init(router: IPlaylistRouter, spotifyService: Lazy<ISpotifyService>, model: Playlist) {
        self.router = router
        self.spotifyService = spotifyService.get()
        self.model = model
        
    }
    
    var viewModels = [RecommendedTrackCellModel]()
    
    // MARK: - 
    func viewDidLoad() {
        fetchPlaylistDetails()
    }
}

private extension PlaylistPresenter {
    func fetchPlaylistDetails() {
        spotifyService.getPlaylistDetails(playlistID: model.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self?.view?.configure(with: model)
                    self?.viewModels = model.tracks.items.compactMap({ RecommendedTrackCellModel(
                        name: $0.track.name,
                        artistName: $0.track.artists.first?.name ?? "Unknown Artist",
                        artworkURL: self?.makeOptionalURL(from: $0.track.album?.images.first?.url))
                    })
                    self?.view?.reloadData()
                case .failure(let error):
                    print("Пришла ошибка на запрос getPlaylistDetails: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func makeOptionalURL(from urlString: String?) -> URL? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        return url
        
    }
}



