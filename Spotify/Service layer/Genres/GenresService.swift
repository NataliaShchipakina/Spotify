//
//  GenresService.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

protocol IGenresService {
    func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void))
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse , Error>) -> Void))
}

final class GenresService: IGenresService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - ISpotifyService
    
    func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenresResponse , Error>) -> Void)) {
        let endpoint = GenresEndpoint.getRecommendedGenres
        requestProcessor.load(endpoint, completion: completion)
    }
    
    func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse , Error>) -> Void)) {
        let seeds = genres.joined(separator: ",")
        let endpoint = GenresEndpoint.getRecommendations(genres: seeds)
        requestProcessor.load(endpoint, completion: completion)
    }
}
