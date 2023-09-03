//
//  PlaylistsEndpoint.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

enum PlaylistsEndpoint {
    case getFeaturedPlaylists(limit: Int)
    case getPlaylistDetails(playlistID: String)
}

// MARK: - Endpoint

extension PlaylistsEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case .getFeaturedPlaylists:
            return "/browse/featured-playlists"
        case .getPlaylistDetails(playlistID: let playlistID):
            return "/playlists/\(playlistID)"
         }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var headers: [String: String]? {
        guard let token: String = TokenManager.shared.getAccessToken() else { fatalError("Don't run this request without token") }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var urlQueryParameters: [URLQueryItem] {
        switch self {
        case .getFeaturedPlaylists(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
         case .getPlaylistDetails:
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
