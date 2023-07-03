//
//  AuthManager.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import Foundation

final class AuthManager {
    
    static let shred = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
}
