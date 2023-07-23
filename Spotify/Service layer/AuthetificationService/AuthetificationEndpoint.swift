//
//  AuthetificationEndpoint.swift
//  Spotify
//
//  Created by Eugene Dudkin on 23.07.2023.
//

import Foundation

// MARK: - AuthetificationEndpoint

enum AuthetificationEndpoint {
    case getAuthentificationTokens(authentificationCode: String)
    case getRefreshedAuthentificationTokens(refreshToken: String)
}

// MARK: - Endpoint

extension AuthetificationEndpoint: Endpoint {
    
    var baseURL: String { "https://accounts.spotify.com/api/token" }
    
    var path: String { "" }
    
    var httpMethod: HTTPMethod { .post }
    
    var headers: [String: String]? {
        let clientID = "3c97f978fe294c9a8f333a584e9237c7"
        let clientSecret = "524152b77f8142f9a3a7c0ed4d7325eb"
        let basicToken = clientID + ":" + clientSecret
        let data = basicToken.data(using: .utf8)
        let base64String = data?.base64EncodedString() ?? ""
        
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64String)"
        ]
    }
    
    var urlQueryParameters: [URLQueryItem] { [] }
    
    var httpBodyQueryParameters: [URLQueryItem] {
        switch self {
        case .getAuthentificationTokens(authentificationCode: let code):
            return [
                URLQueryItem(name: "grant_type", value: "authorization_code"),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "redirect_uri", value: "https://github.com/NataliaShchipakina")
            ]
        case .getRefreshedAuthentificationTokens(refreshToken: let refreshToken):
            return [
                URLQueryItem(name: "grant_type", value: "refresh_token"),
                URLQueryItem(name: "refresh_token", value: refreshToken)
            ]
        }
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
