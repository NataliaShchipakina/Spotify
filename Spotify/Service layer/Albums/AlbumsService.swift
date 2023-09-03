//
//  AlbumsService.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

protocol IAlbumsService {
    func getNewReleases(limit: Int, completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void)
    func getAlbumDetails(albumID: String, completion: @escaping ((Result<AlbumDetailResponse , Error>) -> Void))
}

final class AlbumsService: IAlbumsService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - ISpotifyService
    
    func getNewReleases(limit: Int, completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        let endpoint = AlbumsEndpoint.getNewReleases(limit: limit)
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getAlbumDetails(albumID: String, completion: @escaping ((Result<AlbumDetailResponse, Error>) -> Void)) {
        let endpoint = AlbumsEndpoint.getAlbumDetails(albumID: albumID)
        requestProcessor.load(endpoint, completion: completion)
    }
}
