//
//  HomePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IHomePresenter {
    var sections: [BrowseSectionType] { get }
    func viewDidLoad()
    func didTapSettingsButton()
    func didSelectItem(at indexPath: IndexPath)
}

final class HomePresenter: IHomePresenter {
    
    var sections = [BrowseSectionType]()

    var newReleases: NewReleasesResponse?
    var featuredPlaylist: FeaturedPlaylistsResponse?
    var recommendations: RecommendationsResponse?
    
    // MARK: - Dependencies
    
    private let router: IHomeRouter
    private let spotifyService: ISpotifyService
    
    weak var view: IHomeView?
    
    // MARK: - Init
    
    init(router: IHomeRouter, spotifyService: Lazy<ISpotifyService>) {
        self.router = router
        self.spotifyService = spotifyService.get()
    }
    
    // MARK: - IHomePresenter
    
    func viewDidLoad() {
        fetchData()
    }
    
    func didTapSettingsButton() {
        router.showSettingScreen()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let model = sections[indexPath.section]

        switch model {
        case .newReleases:
            guard let album = newReleases?.albums.items[indexPath.row] else { return }
            router.showAlbumDetailsScreen(model: album)
        case .featuredPlaylists:
            guard let playlist = featuredPlaylist?.playlists.items[indexPath.row] else { return }
            router.showPlaylistDetailsScreen(model: playlist)
        case .recommendedTracks:
            return
        }
    }
}

private extension HomePresenter {
    func fetchData() {
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        spotifyService.getRecommendedGenres { [weak self] result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                self?.spotifyService.getRecommendations(genres: seeds) { [weak self] recommendedResult  in
                    defer {
                        group.leave()
                    }
                    switch recommendedResult {
                    case .success(let response):
                        self?.recommendations = response
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                break
            }
        }
        
        spotifyService.getFeaturedPlaylists(limit: 30) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                self?.featuredPlaylist = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        spotifyService.getNewReleases(limit: 30) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                self?.newReleases = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let newAlbums = self?.newReleases?.albums.items,
                  let playlists = self?.featuredPlaylist?.playlists.items,
                  let tracks = self?.recommendations?.tracks else {
                return
            }
            
            self?.configureModels(
                newAlbums: newAlbums,
                playlists: playlists,
                tracks: tracks
            )
            
            self?.view?.reloadData()
        }
    }
    
    private func configureModels(
        newAlbums: [Album],
        playlists: [Playlist],
        tracks: [AudioTrack]
    ) {
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewReleasesCellModel(
                name: $0.name,
                artworkURL: makeURL(from: $0.images.first?.url),
                numberOfTracks: $0.totalTracks,
                artistName: $0.artists.first?.name ?? "Unknown Artist")
        })))
        sections.append(.featuredPlaylists(viewModels: playlists.compactMap({
            return FeaturedPlaylistCellModel(
                name: $0.name,
                artworkURL: makeURL(from: $0.images.first?.url),
                creatorName: $0.owner.displayName
            )
        })))
        sections.append(.recommendedTracks(viewModels: tracks.compactMap({
            return RecommendedTrackCellModel(
                name: $0.name,
                artistName: $0.artists.first?.name ?? "Unknown Artist",
                artworkURL: makeURL(from: $0.album?.images.first?.url))
        })))
        self.view?.reloadData()
    }
    
    private func makeURL(from urlString: String?) -> URL? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}
