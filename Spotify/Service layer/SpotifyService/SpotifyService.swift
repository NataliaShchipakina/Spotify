//
//  APICaller.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import Foundation

protocol ISpotifyService {
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
    func getNewReleases(limit: Int, completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void)
    func getFeaturedPlaylists(limit: Int, completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void))
    func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void))
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse , Error>) -> Void))
    func getAlbumDetails(albumID: String, completion: @escaping ((Result<AlbumDetailResponse , Error>) -> Void))
    func getPlaylistDetails(playlistID: String, completion: @escaping ((Result<PlaylistDetailsResponse , Error>) -> Void))
}

final class SpotifyService: ISpotifyService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - ISpotifyService
    
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let endpoint = SpotifyEndpoint.getCurrentUserProfile
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getNewReleases(limit: Int, completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        let endpoint = SpotifyEndpoint.getNewReleases(limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getFeaturedPlaylists(limit: Int, completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)) {
        let endpoint = SpotifyEndpoint.getFeaturedPlaylists(limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void)) {
        let endpoint = SpotifyEndpoint.getRecommendedGenres
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse , Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        let endpoint = SpotifyEndpoint.getRecommendations(genres: seeds)
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getAlbumDetails(albumID: String, completion: @escaping ((Result<AlbumDetailResponse, Error>) -> Void)) {
        let endpoint = SpotifyEndpoint.getAlbumDetails(albumID: albumID)
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getPlaylistDetails(playlistID: String, completion: @escaping ((Result<PlaylistDetailsResponse , Error>) -> Void)) {
        let endpoint = SpotifyEndpoint.getPlaylistDetails(playlistID: playlistID)
        requestProcessor.load(endpoint, completion: completion)
    }
}
