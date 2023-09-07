//
//  CategoryPlaylistsRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoryPlaylistsRouter {
    func showPlaylistScreen(model: Playlist)
}

final class CategoryPlaylistsRouter: ICategoryPlaylistsRouter {

    // MARK: - Dependencies

    private let playlistAssembly: Lazy<IPlaylistAssembly>
    
    weak var transitionHandler: UIViewController?

    // MARK: - Init

    init(playlistAssembly: Lazy<IPlaylistAssembly>) {
        self.playlistAssembly = playlistAssembly
    }

    // MARK: - ICategoriesRouter
    
    func showPlaylistScreen(model: Playlist) {
        let playlistVC = playlistAssembly.get().assemble(model: model)
        transitionHandler?.navigationController?.pushViewController(playlistVC, animated: true)
    }
}
