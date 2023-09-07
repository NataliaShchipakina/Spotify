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

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
}
