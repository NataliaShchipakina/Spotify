//
//  AlbumDetailsAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import UIKit

protocol IAlbumAssembly {
    func assemble(model: Album) -> UIViewController
}

final class AlbumDetailsAssembly: IAlbumAssembly {
    
    // MARK: - Dependencies
    
    private let albumsService: Lazy<IAlbumsService>
    
    // MARK: - Init
    
    init(albumsService: Lazy<IAlbumsService>) {
        self.albumsService = albumsService
    }
    
    // MARK: - IAlbumAssembly
    
    func assemble(model: Album) -> UIViewController {
        let router = AlbumDetailsRouter()
        let presenter = AlbumDetailsPresenter(router: router, albumsService: albumsService, model: model)
        let viewController = AlbumDetailsViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController
        
        return viewController
    }
}
