//
//  PlaylistAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import UIKit

protocol IPlaylistAssembly {
    func assemble(model: PlaylistDetailsResponse) -> UIViewController
}

final class PlaylistAssembly: IPlaylistAssembly {
    
    // MARK: - Dependencies
    
    private let spotifyService: Lazy<ISpotifyService>
    
    // MARK: - Init
    
    init(spotifyService: Lazy<ISpotifyService>) {
        self.spotifyService = spotifyService
    }
    
    // MARK: - IAlbumAssembly
    
    func assemble(model: PlaylistDetailsResponse) -> UIViewController {
        let router = PlaylistRouter()
        let presenter = PlaylistPresenter(router: router, spotifyService: spotifyService, model: model)
        let viewController = PlaylistViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        
        return viewController
    }
}


