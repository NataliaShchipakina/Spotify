//
//  GenresEndpoint.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

// MARK: - GenresEndpoint

enum GenresEndpoint {
    case getRecommendedGenres
    case getRecommendations(genres: String)
}

// MARK: - Endpoint

extension GenresEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case .getRecommendedGenres:
            return "/recommendations/available-genre-seeds"
        case .getRecommendations:
            return "/recommendations"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var headers: [String: String]? {
        guard let token: String = TokenManager.shared.getAccessToken() else { fatalError("Don't run this request without token") }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var urlQueryParameters: [URLQueryItem] {
        switch self {
        case .getRecommendedGenres:
            return []
        case .getRecommendations(genres: let genres):
            return [URLQueryItem(name: "seed_genres", value: genres)]
         }
    }
    
    var httpBodyQueryParameters: [URLQueryItem] {
        []
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
