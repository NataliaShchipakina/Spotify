//
//  PlaylistDetailsResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct  PlaylistItem: Codable {
    let track: AudioTrack
}
