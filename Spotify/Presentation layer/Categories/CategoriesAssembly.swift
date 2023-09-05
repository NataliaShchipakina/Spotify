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
    
    private let categoriesService: Lazy<ICategoriesService>
    private let categoryPlaylistAssembly: Lazy<ICategoryPlaylistsAssembly>

    // MARK: - Init
    
    init(categoriesService: Lazy<ICategoriesService>, categoryPlaylistAssembly: Lazy<ICategoryPlaylistsAssembly>) {
        self.categoriesService = categoriesService
        self.categoryPlaylistAssembly = categoryPlaylistAssembly
    }
    // MARK: - ICategoriesAssembly
        
    func assembly() -> UIViewController {
        let router = CategoriesRouter(categoryPlaylistsAssembly: categoryPlaylistAssembly)
        let presenter = CategoriesPresenter(router: router, categoriesService: categoriesService)
        let viewController = CategoriesViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        return viewController
    }
}
