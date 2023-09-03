//
//  UsersEndpoint.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

// MARK: - UsersEndpoint

enum UsersEndpoint {
    case getCurrentUserProfile
}

// MARK: - Endpoint

extension UsersEndpoint: Endpoint {
    var baseURL: String { "https://api.spotify.com/v1" }
    
    var path: String {
        switch self {
        case .getCurrentUserProfile:
            return "/me"
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
