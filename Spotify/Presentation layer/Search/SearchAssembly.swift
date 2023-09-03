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
    private let categoryAssembly: Lazy<ICategoriesAssembly>

    // MARK: - Init
    
    init(
        spotifyService: Lazy<ISpotifyService>,
        categoryAssembly: Lazy<ICategoriesAssembly>
    ) {
        self.spotifyService = spotifyService
        self.categoryAssembly = categoryAssembly
    }
    // MARK: - ISearchAssembly
        
    func assembly() -> UIViewController {
        let router = SearchRouter(categoriesAssembly: categoryAssembly)
        let presenter = SearchPresenter(router: router, spotifyService: spotifyService)
        let viewController = SearchViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        return viewController
    }
}
