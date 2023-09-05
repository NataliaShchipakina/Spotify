//
//  CategoryPlaylistsPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import Foundation

protocol ICategoryPlaylistsPresenter {
    func viewDidLoad()
    func playlistDidTap(with index: Int)
    var caterogy: Category { get }
    var categoriesPlaylistsResponse: CategoriesPlaylistsResponse? { get }
}

final class CategoryPlaylistsPresenter: ICategoryPlaylistsPresenter {
    
    // MARK: - Dependencies
    
    private let router: ICategoryPlaylistsRouter
    private let categoriesService: Lazy<ICategoriesService>
    var categoriesPlaylistsResponse: CategoriesPlaylistsResponse?
    let caterogy: Category
    
    weak var view: ICategoryPlaylistsView?
    
    // MARK: - Init
    
    init(router: ICategoryPlaylistsRouter, categoriesService: Lazy<ICategoriesService>, caterogy: Category) {
        self.router = router
        self.categoriesService = categoriesService
        self.caterogy = caterogy
    }
    
    func viewDidLoad() {
        fetchCategoryPlaylist()
    }
    
    func playlistDidTap(with index: Int) {
        guard let playlist = categoriesPlaylistsResponse?.playlists.items[index] else { return }
        router.showPlaylistScreen(model: playlist)
    }
}
// MARK: - ICategoriesPresenter

private extension CategoryPlaylistsPresenter {
    func fetchCategoryPlaylist() {
        
        categoriesService.get().getCategoryPlaylists(categoryID: caterogy.id, limit: 50) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let response):
                    self?.categoriesPlaylistsResponse = response
                    self?.view?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
