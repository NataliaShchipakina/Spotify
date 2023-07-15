//
//  DependenciesAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IDependenciesAssembly {
    
    // MARK: - Core

    // MARK: - Services
    
    var spotifyService: Lazy<ISpotifyService> { get }

    // MARK: - Presentation

    var tabBarAssembly: Lazy<ITabBarAssembly> { get }
    var welcomeAssembly: Lazy<IWelcomeAssembly> { get }
    var homeAssembly: Lazy<IHomeAssembly> { get }
}

final class DependenciesAssembly: IDependenciesAssembly {
    
    // MARK: - Core
    
    // MARK: - Services
    
    var spotifyService: Lazy<ISpotifyService> {
        Lazy(SpotifyService.shared)
    }
    
    // MARK: - Presentation
    
    var tabBarAssembly: Lazy<ITabBarAssembly> {
        Lazy(TabBarAssembly(viewControllers: [
            self.homeAssembly.get().assemble(),
            SearchViewController(),
            LibraryViewController()
        ]))
    }
    
    var welcomeAssembly: Lazy<IWelcomeAssembly> {
        Lazy(WelcomeAssembly(tabBarAssembly: self.tabBarAssembly))
    }
    
    var homeAssembly: Lazy<IHomeAssembly> {
        Lazy(HomeAssembly())
    }
}
