//
//  CategoriesAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoriesAssembly {
    func assembly(caterogy: Category) -> UIViewController
}

final class CategoriesAssembly: ICategoriesAssembly {
    
    
    // MARK: - Dependencies
    
    private let spotifyService: Lazy<ISpotifyService>
    private let playlistAssembly: Lazy<IPlaylistAssembly>
    
    // MARK: - Init
    
    init(
        spotifyService: Lazy<ISpotifyService>,
        playlistAssembly: Lazy<IPlaylistAssembly>
    ) {
        self.spotifyService = spotifyService
        self.playlistAssembly = playlistAssembly
    }
    
    // MARK: - ICategoriesAssembly
    
    func assembly(caterogy: Category) -> UIViewController {
        let router = CategoriesRouter(playlistAssembly: playlistAssembly)
        let presenter = CategoriesPresenter(router: router, spotifyService: spotifyService, caterogy: caterogy)
        let viewController = CategoriesViewController(presenter: presenter)
        router.transitionHandler = viewController
        presenter.view = viewController
        
        return viewController
    }
}
