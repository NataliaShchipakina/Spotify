//
//  Playlist.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.07.2023.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
