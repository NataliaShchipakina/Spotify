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
}

final class HomePresenter: IHomePresenter {
    
    var sections = [BrowseSectionType]()
    
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
}

private extension HomePresenter {
    func fetchData() {
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlaylistsResponse?
        var recommendations: RecommendationsResponse?

        
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
                    case .success(let model):
                        recommendations = model
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            
            case .failure(let error):
                // view?.showErrorState()
                break
            }
        }
        
        spotifyService.getFeaturedPlaylists(limit: 5) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        spotifyService.getNewReleases(limit: 6) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {
                return
            }
            
            self.configureModels(
                newAlbums: newAlbums,
                playlists: playlists,
                tracks: tracks
            )
            
            self.view?.reloadData()
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
                artworkURL: URL(string: $0.images.first?.url ?? ""),
                numberOfTracks: $0.totalTracks,
                artistName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylists(viewModels: []))
        sections.append(.recommendedTracks(viewModels: []))
        self.view?.reloadData()
    }
    
}
