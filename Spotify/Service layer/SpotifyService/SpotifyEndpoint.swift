//
//  SpotifyEndpoint.swift
//  Spotify
//
//  Created by Eugene Dudkin on 22.07.2023.
//

import Foundation

// MARK: - SpotifyEndpoint

enum SpotifyEndpoint {
    case getCurrentUserProfile
    case getNewReleases(limit: Int)
    case getFeaturedPlaylists(limit: Int)
    case getRecommendedGenres
    case getRecommendations(genres: String)
    case getAlbumDetails(albumID: String)
    case getPlaylistDetails(playlistID: String)
    case getCategories(limit: Int)
    case getCategoryPlaylists(categoryID: String)
}

// MARK: - Endpoint

extension SpotifyEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case .getCurrentUserProfile:
            return "/me"
        case .getNewReleases:
            return "/browse/new-releases"
        case .getFeaturedPlaylists:
            return "/browse/featured-playlists"
        case .getRecommendedGenres:
            return "/recommendations/available-genre-seeds"
        case .getRecommendations:
            return "/recommendations"
        case .getAlbumDetails(albumID: let albumID):
            return "/albums/\(albumID)"
        case .getPlaylistDetails(playlistID: let playlistID):
            return "/playlists/\(playlistID)"
        case.getCategories:
            return "/browse/categories"
        case .getCategoryPlaylists(categoryID: let categoryID):
            return "/albums/\(categoryID)/playlists?limit=20"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var headers: [String: String]? {
        guard let token: String = TokenManager.shared.getAccessToken() else { fatalError("Don't run this request without token") }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var urlQueryParameters: [URLQueryItem] {
        switch self {
        case .getCurrentUserProfile:
            return []
        case .getNewReleases(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        case .getFeaturedPlaylists(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        case .getRecommendedGenres:
            return []
        case .getRecommendations(genres: let genres):
            return [URLQueryItem(name: "seed_genres", value: genres)]
        case .getAlbumDetails:
            return []
        case .getPlaylistDetails:
            return []
        case .getCategories(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        case .getCategoryPlaylists:
            return []
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
