//
//  CategoryPlaylistsAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoryPlaylistsAssembly {
    func assembly(caterogy: Category) -> UIViewController
}

final class CategoryPlaylistsAssembly: ICategoryPlaylistsAssembly {
    
    
    // MARK: - Dependencies
    
    private let categoriesService: Lazy<ICategoriesService>
    private let playlistAssembly: Lazy<IPlaylistAssembly>
    
    // MARK: - Init
    
    init(
        categoriesService: Lazy<ICategoriesService>,
        playlistAssembly: Lazy<IPlaylistAssembly>
    ) {
        self.categoriesService = categoriesService
        self.playlistAssembly = playlistAssembly
    }
    
    // MARK: - ICategoriesAssembly
    
    func assembly(caterogy: Category) -> UIViewController {
        let router = CategoryPlaylistsRouter(playlistAssembly: playlistAssembly)
        let presenter = CategoryPlaylistsPresenter(router: router, categoriesService: categoriesService, caterogy: caterogy)
        let viewController = CategoryPlaylistsViewController(presenter: presenter)
        router.transitionHandler = viewController
        presenter.view = viewController
        
        return viewController
    }
}
