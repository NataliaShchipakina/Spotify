//
//  HomeRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IHomeRouter {
    func showSettingScreen()
    func showAlbumDetailsScreen(model: Album)
    func showPlaylistDetailsScreen(model: Playlist)
}

final class HomeRouter: IHomeRouter {
    
    // MARK: - Dependencies
    
    private let settingAssembly: Lazy<ISettingsAssembly>
    private let albumAssembly: Lazy<IAlbumAssembly>
    private let playlistAssembly: Lazy<IPlaylistAssembly>
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(settingAssembly: Lazy<ISettingsAssembly>, albumAssembly: Lazy<IAlbumAssembly>, playlistAssembly: Lazy<IPlaylistAssembly>)  {
        self.settingAssembly = settingAssembly
        self.albumAssembly = albumAssembly
        self.playlistAssembly = playlistAssembly
    }
    
    // MARK: - IHomeRouter
    
    func showSettingScreen() {
        let settingsViewController = settingAssembly.get().assemble()
        transitionHandler?.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func showAlbumDetailsScreen(model: Album) {
        let albumVC = albumAssembly.get().assemble(model: model)
        transitionHandler?.navigationController?.pushViewController(albumVC, animated: true)
    }
    
    func showPlaylistDetailsScreen(model: Playlist) {
        let playlistVC = playlistAssembly.get().assemble(model: model)
        transitionHandler?.navigationController?.pushViewController(playlistVC, animated: true)
    }
}
