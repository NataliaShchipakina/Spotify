//
//  CategoriesAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ICategoriesAssembly {
    func assembly() -> UIViewController
}

final class CategoriesAssembly: ICategoriesAssembly {
    
    // MARK: - Dependencies
    
    private let spotifyService: Lazy<ISpotifyService>
    private let categoryPlaylistsAssembly: Lazy<ICategoryPlaylistsAssembly>

    // MARK: - Init
    
    init(
        spotifyService: Lazy<ISpotifyService>,
        categoryPlaylistsAssembly: Lazy<ICategoryPlaylistsAssembly>
    ) {
        self.spotifyService = spotifyService
        self.categoryPlaylistsAssembly = categoryPlaylistsAssembly
    }
    // MARK: - ICategoriesAssembly
        
    func assembly() -> UIViewController {
        let router = CategoriesRouter(categoriesAssembly: categoryPlaylistsAssembly)
        let presenter = CategoriesPresenter(router: router, spotifyService: spotifyService)
        let viewController = CategoriesViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        return viewController
    }
}
