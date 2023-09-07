//
//  CategoriesRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ICategoriesRouter {
    func showCategoryPlaylistsScreen(category: Category)
}

final class CategoriesRouter: ICategoriesRouter {
    
    // MARK: - Dependencies
    
    private let categoryPlaylistsAssembly: Lazy<ICategoryPlaylistsAssembly>
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(categoryPlaylistsAssembly: Lazy<ICategoryPlaylistsAssembly>) {
        self.categoryPlaylistsAssembly = categoryPlaylistsAssembly
    }
    
    // MARK: - ICategoriesRouter
    
    func showCategoryPlaylistsScreen(category: Category) {
        let categoriesVC = categoryPlaylistsAssembly.get().assembly(caterogy: category)
        transitionHandler?.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}

