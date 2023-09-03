//
//  CategoriesPlaylistsResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

// MARK: - CategoriesPlaylistsResponse
struct CategoriesPlaylistsResponse: Codable {
    let message: String?
    let playlists: Playlists
}

// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [Playlist]
}
