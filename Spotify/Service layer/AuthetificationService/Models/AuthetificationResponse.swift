//
//  AuthResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 05.07.2023.
//

import Foundation

struct AuthetificationResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
}
