//
//  AudioTrack.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.07.2023.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber, durationMs: Int
    let explicit: Bool
    let externalUrls: [String: String]
    let id: String
    let name: String
    let popularity: Int
   
//
//    enum CodingKeys: String, CodingKey {
//        case album, artists, explicit
//        case availableMarkets = "available_markets"
//        case discNumber = "disc_number"
//        case durationMS = "duration_ms"
//        case externalUrls = "external_urls"
//        case id, name, popularity
//    }
}
