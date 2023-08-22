//
//  PlaylistHeaderViewModel.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 17.08.2023.
//

import Foundation

struct PlaylistHeaderViewModel {
    let name: String
    let ownerName: String
    let description: String
    let artworkURL: URL?
    
    static let empty = PlaylistHeaderViewModel(name: "", ownerName: "", description: "", artworkURL: nil)
}
