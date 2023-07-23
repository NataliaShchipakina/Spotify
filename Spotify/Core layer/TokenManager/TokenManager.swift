//
//  TokenManager.swift
//  Spotify
//
//  Created by Eugene Dudkin on 23.07.2023.
//

import Foundation

protocol ITokenManager {
    func getAccessToken() -> String?
    func getRefreshToken() -> String?
    func getExpirationDate() -> Date?
    func saveTokens(_ tokens: AuthetificationResponse)
}

final class TokenManager: ITokenManager {
    
    // MARK: - Constants

    private let accessTokenKey = "accessTokenKey"
    private let refreshTokenKey = "refreshTokenKey"
    private let expirationDateKey = "expirationDate"
    
    // MARK: - Dependencies
    
    private let storageManager: Lazy<IStorageManager>

    // MARK: - Init
    
    init(storageManager: Lazy<IStorageManager>) {
        self.storageManager = storageManager
    }
    
    // MARK: - ITokenManager
    
    func getAccessToken() -> String? {
        storageManager.get().get(key: accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        storageManager.get().get(key: refreshTokenKey)
    }
    
    func getExpirationDate() -> Date? {
        storageManager.get().get(key: expirationDateKey)
    }
    
    func saveTokens(_ tokens: AuthetificationResponse) {
        storageManager.get().set(key: accessTokenKey, value: tokens.accessToken)
        
        let expirationDate = Date().addingTimeInterval(TimeInterval(tokens.expiresIn))
        storageManager.get().set(key: expirationDateKey, value: expirationDate)

        if let refreshToken = tokens.refreshToken {
            storageManager.get().set(key: refreshTokenKey, value: refreshToken)
        }
    }
}

