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
    
    enum CodingKeys: String, CodingKey {
            case country, email, id, product, images
            case displayName = "display_name"
            case explicitContent = "explicit_content"
            case externalUrls = "external_urls"
    }
}


