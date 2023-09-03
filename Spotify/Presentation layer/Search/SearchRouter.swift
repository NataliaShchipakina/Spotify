//
//  SearchRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ISearchRouter {
    func showACategoriesScreen(categories: Category)
}

final class SearchRouter: ISearchRouter {
    
    // MARK: - Dependencies
    
    private let categoriesAssembly: Lazy<ICategoriesAssembly>
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(categoriesAssembly: Lazy<ICategoriesAssembly>) {
        self.categoriesAssembly = categoriesAssembly
    }
    
    // MARK: - ISearchRouter
    
    func showACategoriesScreen(categories: Category) {
        let categoriesVC = categoriesAssembly.get().assembly(caterogy: categories)
        transitionHandler?.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}

