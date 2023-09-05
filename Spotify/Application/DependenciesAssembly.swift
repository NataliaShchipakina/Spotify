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
    var categoriesService: Lazy<ICategoriesService> { get }
    var albumsService: Lazy<IAlbumsService> { get }
    var playlistsService: Lazy<IPlaylistsService> { get }
    var genresService: Lazy<IGenresService> { get }
    var userService: Lazy<IUserService> { get }
    
    // MARK: - Presentation
    
    var loadingAssembly: Lazy<ILoadingAssembly> { get }
    var tabBarAssembly: Lazy<ITabBarAssembly> { get }
    var welcomeAssembly: Lazy<IWelcomeAssembly> { get }
    var authetificationAssembly: Lazy<IAuthetificationAssembly> { get }
    var homeAssembly: Lazy<IHomeAssembly> { get }
    var settingsAssembly: Lazy<ISettingsAssembly> { get }
    var profileAssembly: Lazy<IProfileAssembly> { get }
    var categoriesAssembly: Lazy<ICategoriesAssembly> {get}
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
    
    var categoriesService: Lazy<ICategoriesService> {
        Lazy(CategoriesService(requestProcessor: self.requestProcessor))
    }
    
    var albumsService: Lazy<IAlbumsService> {
        Lazy(AlbumsService(requestProcessor: self.requestProcessor))
    }
    
    var playlistsService: Lazy<IPlaylistsService> {
        Lazy(PlaylistsService(requestProcessor: self.requestProcessor))
    }
    
    var genresService: Lazy<IGenresService> {
        Lazy(GenresService(requestProcessor: self.requestProcessor))
    }
    
    var userService: Lazy<IUserService> {
        Lazy(UserService(requestProcessor: self.requestProcessor))
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
            self.categoriesAssembly.get().assembly(),
            LibraryViewController()
        ]))
    }
    
    var welcomeAssembly: Lazy<IWelcomeAssembly> {
        Lazy(WelcomeAssembly(
            tabBarAssembly: self.tabBarAssembly,
            authetificationAssembly: self.authetificationAssembly
        ))
    }
    
    var categoriesAssembly: Lazy<ICategoriesAssembly> {
        Lazy(CategoriesAssembly(categoriesService: self.categoriesService, categoryPlaylistAssembly: self.categoryPlaylistsAssembly))
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
        Lazy(AlbumDetailsAssembly(albumsService: self.albumsService))
    }
    
    var playlistAssembly: Lazy<IPlaylistAssembly> {
        Lazy(PlaylistAssembly(playlistsService: self.playlistsService))
    }
    
    var profileAssembly: Lazy<IProfileAssembly> {
        Lazy(ProfileAssembly(userService: self.userService))
    }
    
    var categoryPlaylistsAssembly: Lazy<ICategoryPlaylistsAssembly> {
        Lazy(CategoryPlaylistsAssembly(categoriesService: self.categoriesService, playlistAssembly: self.playlistAssembly))
    }
    
}
