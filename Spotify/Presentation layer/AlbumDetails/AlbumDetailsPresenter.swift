//
//  AlbumDetailsPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import Foundation

protocol IAlbumPresenter {
    func viewDidLoad()
}

final class AlbumDetailsPresenter: IAlbumPresenter {
    
    // MARK: - Dependencies
    
    private let router: IAlbumRouter
    private let spotifyService: ISpotifyService
    private let model: AlbumDetailResponse
    
    weak var view: IAlbumView?
    
    // MARK: - Init
    
    init(router: IAlbumRouter, spotifyService: Lazy<ISpotifyService>, model: AlbumDetailResponse) {
        self.router = router
        self.spotifyService = spotifyService.get()
        self.model = model
        
    }
    
    // MARK: -
    func viewDidLoad() {}
}

