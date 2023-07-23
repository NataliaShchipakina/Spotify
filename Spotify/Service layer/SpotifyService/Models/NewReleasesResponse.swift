//
//  NewReleasesResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 14.07.2023.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

struct AlbumResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let albumType: String
    let availableMarkets: [String]
    let id: String
    let images: [APIImage]
    let name: String
    let releaseDate: String
    let totalTracks: Int
    let artists: [Artist]
}
