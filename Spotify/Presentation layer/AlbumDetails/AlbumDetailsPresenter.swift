//
//  AlbumDetailsPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import Foundation

protocol IAlbumPresenter {
    var headerViewModel: PlaylistHeaderViewModel { get }
    var viewModels: [AlbumCollectionViewCellVM] { get }
    func viewDidLoad()
}

final class AlbumDetailsPresenter: IAlbumPresenter {
    
    // MARK: - Dependencies
    
    private let router: IAlbumRouter
    private let spotifyService: Lazy<ISpotifyService>
    private let model: Album
    private var tracks = [AudioTrack]()
    
    weak var view: IAlbumView?
    
    // MARK: - Init
    
    init(router: IAlbumRouter, spotifyService: Lazy<ISpotifyService>, model: Album) {
        self.router = router
        self.spotifyService = spotifyService
        self.model = model
    }
 
    // MARK: - IAlbumPresenter
    
    var headerViewModel: PlaylistHeaderViewModel = .empty
    var viewModels = [AlbumCollectionViewCellVM]()
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        fetchAlbumDetails()
    }
    
    func didTapActionButton() { }
}

private extension AlbumDetailsPresenter {
    func fetchAlbumDetails() {
        spotifyService.get().getAlbumDetails(albumID: model.id) { [weak self] result in
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
    
    private func handleSuccessResponse(with response: AlbumDetailResponse) {
        // 1. Title
        view?.setTitle(response.name)
        
        // 2.Header
        headerViewModel = PlaylistHeaderViewModel(
            name: response.name,
            ownerName: model.artists.first?.name ?? "Unknown Artist",
            description: "Release Date: \(DateFormatter.formattedDate(string: model.releaseDate))",
            artworkURL: URL(optionalString: response.images.first?.url)
        )
        
        // 3. Cells viewModels
        viewModels = response.tracks.items.compactMap{ AlbumCollectionViewCellVM(
            name: $0.name,
            artistName: $0.artists.first?.name ?? "Unknown Artist")}
        
        // 4. Reload view
        view?.reloadData()
    }
}
