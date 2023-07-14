//
//  Artist.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 14.07.2023.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let externalUrls: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
        case externalUrls = "external_urls"

    }
}


