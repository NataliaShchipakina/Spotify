//
//  CategoriesPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import Foundation

protocol ICategoriesPresenter {
    func viewDidLoad()
    func didTapCategory(indexRow: Int)
    var categories: AllCategoriesResponse? { get }
}

final class CategoriesPresenter: ICategoriesPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoriesRouter
    private let categoriesService: Lazy<ICategoriesService>

    var categories: AllCategoriesResponse?
    
    weak var view: ICategoriesView?
    
    // MARK: - Init
    
    init(router: ICategoriesRouter, categoriesService: Lazy<ICategoriesService>) {
        self.router = router
        self.categoriesService = categoriesService
    }
    
    // MARK: - Lifecycle
    
    func viewDidLoad() {
        fetchCategories()
    }
    
    func didTapCategory(indexRow: Int) {
        guard let model = categories?.categories.items[indexRow] else { return }
        router.showCategoryPlaylistsScreen(category: model)
    }
}
// MARK: - ICategoriesPresenter

private extension CategoriesPresenter {
    func fetchCategories() {
        categoriesService.get().getCategories(limit: 50) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let response):
                    self?.categories = response
                    self?.view?.reloadData()
                case .failure(let error):
                    preconditionFailure("error come")
                }
            }
        }
    }
}


