//
//  AlbumDetailResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import Foundation

struct AlbumDetailResponse: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}
