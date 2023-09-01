//
//  CategoriesAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoriesAssembly {
    func assembly(model: Playlist) -> UIViewController
}

final class CategoriesAssembly: ICategoriesAssembly {

    // MARK: - Dependencies
    
    private let spotifyService: Lazy<ISpotifyService>
    

    // MARK: - Init

    init(spotifyService: Lazy<ISpotifyService>) {
        self.spotifyService = spotifyService
    }

    // MARK: - ICategoriesAssembly

    func assembly(model: Playlist) -> UIViewController {
        let router = CategoriesRouter()
        let presenter = CategoriesPresenter(router: router, spotifyService: spotifyService, model: model)
        let viewController = CategoriesViewController(presenter: presenter)
        router.transitionHandler = viewController

        return viewController
    }
}
 
