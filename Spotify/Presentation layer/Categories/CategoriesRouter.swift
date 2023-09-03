//
//  CategoriesRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ICategoriesRouter {
    func showCategoriesScreen(categories: Category)
}

final class CategoriesRouter: ICategoriesRouter {
    
    // MARK: - Dependencies
    
    private let categoriesAssembly: Lazy<ICategoryPlaylistsAssembly>
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(categoriesAssembly: Lazy<ICategoryPlaylistsAssembly>) {
        self.categoriesAssembly = categoriesAssembly
    }
    
    // MARK: - ICategoriesRouter
    
    func showCategoriesScreen(categories: Category) {
        let categoriesVC = categoriesAssembly.get().assembly(caterogy: categories)
        transitionHandler?.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}

