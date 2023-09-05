//
//  PlaylistPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import Foundation

protocol IPlaylistPresenter {
    var headerViewModel: PlaylistHeaderViewModel { get }
    var viewModels: [RecommendedTrackCellModel] { get }
    func viewDidLoad()
    func didTapShareButton()
}

final class PlaylistPresenter: IPlaylistPresenter {
    
    // MARK: - Dependencies
    
    private let router: IPlaylistRouter
    private let playlistsService: IPlaylistsService
    private let playlistModel: Playlist
    
    weak var view: IPlaylistView?
    
    // MARK: - Init
    
    init(router: IPlaylistRouter, playlistsService: Lazy<IPlaylistsService>, model: Playlist) {
        self.router = router
        self.playlistsService = playlistsService.get()
        self.playlistModel = model
    }
        
    // MARK: - IPlaylistPresenter
    
    var headerViewModel: PlaylistHeaderViewModel = .empty
    var viewModels = [RecommendedTrackCellModel]()

    func viewDidLoad() {
        fetchPlaylistDetails()
    }
    
    func didTapShareButton() {
        guard let url = URL(string: playlistModel.externalUrls["spotify"] ?? "") else {
            fatalError()
        }
        router.showActivityViewController(with: url)
    }
}

private extension PlaylistPresenter {
    func fetchPlaylistDetails() {
        playlistsService.getPlaylistDetails(playlistID: playlistModel.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self?.handleSuccessResponse(with: model)
                case .failure(let error):
                    print("Пришла ошибка на запрос getPlaylistDetails: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func handleSuccessResponse(with response: PlaylistDetailsResponse) {
        // 1. Title
        view?.setTitle(response.name)
        
        // 2.Header
        headerViewModel = PlaylistHeaderViewModel(
            name: response.name,
            ownerName: playlistModel.owner.displayName,
            description: response.description,
            artworkURL: URL(optionalString: response.images.first?.url)
        )

        // 3. Cells viewModels
        viewModels = response.tracks.items.compactMap{ RecommendedTrackCellModel(
            name: $0.track.name,
            artistName: $0.track.artists.first?.name ?? "Unknown Artist",
            artworkURL: URL(optionalString: $0.track.album?.images.first?.url))
        }

        // 4. Reload view
        view?.reloadData()
    }
}
