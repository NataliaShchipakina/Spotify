//
//  DependenciesAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IDependenciesAssembly {
    
    // MARK: - Core
    
    var tokenManager: Lazy<ITokenManager> { get }
    var requestProcessor: Lazy<IRequestProcessor> { get }
    var userDefaultsStorage: Lazy<IStorageManager> { get }
    
    // MARK: - Services
    
    var authetificationService: Lazy<IAuthetificationService> { get }
    var spotifyService: Lazy<ISpotifyService> { get }
    
    // MARK: - Presentation
    
    var loadingAssembly: Lazy<ILoadingAssembly> { get }
    var tabBarAssembly: Lazy<ITabBarAssembly> { get }
    var welcomeAssembly: Lazy<IWelcomeAssembly> { get }
    var authetificationAssembly: Lazy<IAuthetificationAssembly> { get }
    var homeAssembly: Lazy<IHomeAssembly> { get }
    var settingsAssembly: Lazy<ISettingsAssembly> { get }
    var profileAssembly: Lazy<IProfileAssembly> { get }
}

final class DependenciesAssembly: IDependenciesAssembly {
    
    // MARK: - Core
    
    var tokenManager: Lazy<ITokenManager>{
        Lazy(TokenManager(storageManager: self.userDefaultsStorage))
    }
    
    var requestProcessor: Lazy<IRequestProcessor>{
        Lazy(RequestProcessor())
    }
    
    var userDefaultsStorage: Lazy<IStorageManager>{
        Lazy(UserDefaultsStorage())
    }
    
    // MARK: - Services
    
    var authetificationService: Lazy<IAuthetificationService> {
        Lazy(AuthetificationService(
            tokenManager: self.tokenManager,
            requestProcessor: self.requestProcessor
        ))
    }
    
    var spotifyService: Lazy<ISpotifyService> {
        Lazy(SpotifyService(requestProcessor: self.requestProcessor))
    }
    
    // MARK: - Presentation
    
    var loadingAssembly: Lazy<ILoadingAssembly> {
        Lazy(LoadingAssembly(
            welcomeAssembly: self.welcomeAssembly,
            authetificationService: self.authetificationService,
            tabBarAssembly: self.tabBarAssembly,
            tokenManager: self.tokenManager
        ))
    }
    
    var tabBarAssembly: Lazy<ITabBarAssembly> {
        Lazy(TabBarAssembly(viewControllers: [
            self.homeAssembly.get().assemble(),
            self.searchAssembly.get().assembly(),
            LibraryViewController()
        ]))
    }
    
    var welcomeAssembly: Lazy<IWelcomeAssembly> {
        Lazy(WelcomeAssembly(
            tabBarAssembly: self.tabBarAssembly,
            authetificationAssembly: self.authetificationAssembly
        ))
    }
    
    var searchAssembly: Lazy<ISearchAssembly> {
        Lazy(SearchAssembly(spotifyService: self.spotifyService, categoryAssembly: self.categoryAssembly))
    }
    
    var authetificationAssembly: Lazy<IAuthetificationAssembly> {
        Lazy(AuthetificationAssembly(authetificationService: self.authetificationService))
    }
    
    var homeAssembly: Lazy<IHomeAssembly> {
        Lazy(HomeAssembly(
            settingAssembly: self.settingsAssembly,
            albumAssembly: self.albumAssembly,
            playlistAssembly: self.playlistAssembly,
            spotifyService: self.spotifyService
        ))
    }
    
    var settingsAssembly: Lazy<ISettingsAssembly> {
        Lazy(SettingsAssembly(profileAssembly: self.profileAssembly))
    }
    
    var albumAssembly: Lazy<IAlbumAssembly> {
        Lazy(AlbumDetailsAssembly(spotifyService: self.spotifyService))
    }
    
    var playlistAssembly: Lazy<IPlaylistAssembly> {
        Lazy(PlaylistAssembly(spotifyService: self.spotifyService))
    }
    
    var profileAssembly: Lazy<IProfileAssembly> {
        Lazy(ProfileAssembly(
            spotifyService: self.spotifyService
        ))
    }
    
    var categoryAssembly: Lazy<ICategoriesAssembly> {
        Lazy(CategoriesAssembly(
            spotifyService: self.spotifyService,
            playlistAssembly: self.playlistAssembly
        ))
    }
}
