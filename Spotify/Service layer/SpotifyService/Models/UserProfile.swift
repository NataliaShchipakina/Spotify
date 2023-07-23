//
//  UserProfile.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.07.2023.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let displayName: String
    let email: String
    let explicitContent: [String: Bool]
    let externalUrls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}

struct APIImage: Codable {
    let url: String
}
