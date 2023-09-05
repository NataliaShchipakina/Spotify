//
//  PlaylistAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import UIKit

protocol IPlaylistAssembly {
    func assemble(model: Playlist) -> UIViewController
}

final class PlaylistAssembly: IPlaylistAssembly {
    
    // MARK: - Dependencies
    
    private let playlistsService: Lazy<IPlaylistsService>
    
    // MARK: - Init
    
    init(playlistsService: Lazy<IPlaylistsService>) {
        self.playlistsService = playlistsService
    }
    
    // MARK: - IAlbumAssembly
    
    func assemble(model: Playlist) -> UIViewController {
        let router = PlaylistRouter()
        let presenter = PlaylistPresenter(router: router, playlistsService: playlistsService, model: model)
        let viewController = PlaylistViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        
        return viewController
    }
}


