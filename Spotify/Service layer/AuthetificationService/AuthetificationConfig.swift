//
//  AuthetificationConfig.swift
//  Spotify
//
//  Created by Eugene Dudkin on 19.07.2023.
//

import Foundation

struct AuthetificationConfig {
    let clientID = "3c97f978fe294c9a8f333a584e9237c7"
    let clientSecret = "524152b77f8142f9a3a7c0ed4d7325eb"
    let tokenAPIURL = "https://accounts.spotify.com/api/token"
    let redirectURI = "https://github.com/NataliaShchipakina"
    let scopes =
        "user-read-private%20" +
        "playlist-modify-public%20" +
        "playlist-read-private%20" +
        "playlist-modify-private%20" +
        "user-follow-read%20" +
        "user-library-modify%20" +
        "user-library-read%20" +
        "user-read-email"
    
     var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string =
            "\(base)?response_type=code" +
            "&client_id=\(clientID)" +
            "&scope=\(scopes)" +
            "&redirect_uri=\(redirectURI)" +
            "&show_dialog=TRUE"
        
        return URL(string: string)
    }
}
