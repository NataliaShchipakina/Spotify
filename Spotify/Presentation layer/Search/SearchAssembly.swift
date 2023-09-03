//
//  SearchAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ISearchAssembly {
    func assembly() -> UIViewController
}

final class SearchAssembly: ISearchAssembly {
    
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
    // MARK: - ISearchAssembly
        
    func assembly() -> UIViewController {
        let router = SearchRouter(categoriesAssembly: categoryPlaylistsAssembly)
        let presenter = SearchPresenter(router: router, spotifyService: spotifyService)
        let viewController = SearchViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        return viewController
    }
}
