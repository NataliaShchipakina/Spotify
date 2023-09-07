//
//  CategoriesEndpoint.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

// MARK: - CategoriesEndpoint

enum CategoriesEndpoint {
    case getCategories(limit: Int)
    case getCategoryPlaylists(categoryID: String, limit: Int)
}

// MARK: - Endpoint

extension CategoriesEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case.getCategories:
            return "/browse/categories"
        case .getCategoryPlaylists(categoryID: let categoryID, limit: _):
            return "/browse/categories/\(categoryID)/playlists"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var headers: [String: String]? {
        guard let token: String = TokenManager.shared.getAccessToken() else { fatalError("Don't run this request without token") }
        return ["Authorization": "Bearer \(token)"]
    }
    
    var urlQueryParameters: [URLQueryItem] {
        switch self {
        case .getCategories(limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        case .getCategoryPlaylists(categoryID: _, limit: let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
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
