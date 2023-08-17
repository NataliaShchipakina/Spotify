//
//  HomeAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IHomeAssembly {
    func assemble() -> UIViewController
}

final class HomeAssembly: IHomeAssembly {
    
    // MARK: - Dependencies
    
    private let settingAssembly: Lazy<ISettingsAssembly>
    private let albumAssembly: Lazy<IAlbumAssembly>
    private let spotifyService: Lazy<ISpotifyService>
    private let playlistAssembly: Lazy<IPlaylistAssembly>
    
    // MARK: - Init
    
    init(
        settingAssembly: Lazy<ISettingsAssembly>,
        albumAssembly: Lazy<IAlbumAssembly>,
        playlistAssembly: Lazy<IPlaylistAssembly>,
        spotifyService: Lazy<ISpotifyService>
    ) {
        self.settingAssembly = settingAssembly
        self.spotifyService = spotifyService
        self.albumAssembly = albumAssembly
        self.playlistAssembly = playlistAssembly
    }
    
    // MARK: - IHomeAssembly
    
    func assemble() -> UIViewController {
        let router = HomeRouter(settingAssembly: settingAssembly, albumAssembly: albumAssembly, playlistAssembly: playlistAssembly)
        let presenter = HomePresenter(router: router, spotifyService: spotifyService)
        let layoutProvider = HomeCollectionViewLayout()
        let viewController = HomeViewController(presenter: presenter, layoutProvider: layoutProvider)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
