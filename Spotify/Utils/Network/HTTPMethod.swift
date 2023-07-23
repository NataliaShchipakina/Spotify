//
//  HTTPMethod.swift
//  Spotify
//
//  Created by Eugene Dudkin on 22.07.2023.
//

import Foundation

/// Допустимые HTTP-методы для выполнения запросов
enum HTTPMethod {
    case get
    case post
    case patch
    case delete
    case put

    var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        }
    }
}
