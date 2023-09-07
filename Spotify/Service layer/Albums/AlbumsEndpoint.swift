//
//  AlbumsEndpoint.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

// MARK: - AlbumsEndpoint

enum AlbumsEndpoint {
    case getNewReleases(limit: Int)
    case getAlbumDetails(albumID: String)
}

// MARK: - Endpoint

extension AlbumsEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case .getNewReleases:
            return "/browse/new-releases"
        case .getAlbumDetails(albumID: let albumID):
            return "/albums/\(albumID)"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var headers: [String: String]? {
        guard let token: String = TokenManager.shared.getAccessToken() else { fatalError("Don't run this request without token") }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var urlQueryParameters: [URLQueryItem] {
        switch self {
        case .getNewReleases(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        case .getAlbumDetails:
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
