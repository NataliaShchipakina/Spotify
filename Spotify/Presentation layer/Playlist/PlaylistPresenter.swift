//
//  PlaylistPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import Foundation

protocol IPlaylistPresenter {
    func viewDidLoad()
}

final class PlaylistPresenter: IPlaylistPresenter {
    
    // MARK: - Dependencies
    
    private let router: IPlaylistRouter
    private let spotifyService: ISpotifyService
    private let model: PlaylistDetailsResponse
    
    weak var view: IPlaylistView?
    
    // MARK: - Init
    
    init(router: IPlaylistRouter, spotifyService: Lazy<ISpotifyService>, model: PlaylistDetailsResponse) {
        self.router = router
        self.spotifyService = spotifyService.get()
        self.model = model
        
    }
    
    // MARK: -
    func viewDidLoad() {}
}
