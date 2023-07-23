//
//  FeaturedPlaylistsResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 14.07.2023.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let message: String
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case description, id, images, name, owner
        case externalUrls = "external_urls"
    }
}

struct User: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
}
