//
//  HomeAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IHomeAssembly {
    func assemble() -> UIViewController
}

final class HomeAssembly: IHomeAssembly {
    
    // MARK: - Dependencies
    
    private let settingAssembly: Lazy<ISettingsAssembly>
    private let spotifyService: Lazy<ISpotifyService>
    
    // MARK: - Init
    
    init(
        settingAssembly: Lazy<ISettingsAssembly>,
        spotifyService: Lazy<ISpotifyService>
    ) {
        self.settingAssembly = settingAssembly
        self.spotifyService = spotifyService
    }
    
    // MARK: - IHomeAssembly
    
    func assemble() -> UIViewController {
        let router = HomeRouter(settingAssembly: settingAssembly)
        let presenter = HomePresenter(router: router, spotifyService: spotifyService)
        let layoutProvider = HomeCollectionViewLayout()
        let viewController = HomeViewController(presenter: presenter, layoutProvider: layoutProvider)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
