//
//  PlaylistsService.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

protocol IPlaylistsService {
    func getFeaturedPlaylists(limit: Int, completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void))
    func getPlaylistDetails(playlistID: String, completion: @escaping ((Result<PlaylistDetailsResponse , Error>) -> Void))
}

final class PlaylistsService: IPlaylistsService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - ISpotifyService
    
     func getFeaturedPlaylists(limit: Int, completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)) {
        let endpoint = PlaylistsEndpoint.getFeaturedPlaylists(limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
    func getPlaylistDetails(playlistID: String, completion: @escaping ((Result<PlaylistDetailsResponse , Error>) -> Void)) {
        let endpoint = PlaylistsEndpoint.getPlaylistDetails(playlistID: playlistID)
        requestProcessor.load(endpoint, completion: completion)
    }
}
