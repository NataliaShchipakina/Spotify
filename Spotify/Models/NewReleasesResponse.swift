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
    
    enum CodingKeys: String, CodingKey {
        case id, images, name, artists
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"

    }
}




