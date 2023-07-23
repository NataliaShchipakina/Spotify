//
//  AuthManager.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import Foundation

protocol IAuthetificationService {
    func getAuthentificationTokens(
        authentificationCode: String,
        completion: ((Result<AuthetificationResponse , Error>) -> Void)?
    )

    func getRefreshedAuthentificationTokens(
        refreshToken: String,
        completion: ((Result<AuthetificationResponse , Error>) -> Void)?
    )
}

final class AuthetificationService: IAuthetificationService {

    // MARK: Dependencies
    
    private let tokenManager: Lazy<ITokenManager>
    private let requestProcessor: Lazy<IRequestProcessor>
    
    // MARK: - Init
    
    init(tokenManager: Lazy<ITokenManager>, requestProcessor: Lazy<IRequestProcessor>) {
        self.tokenManager = tokenManager
        self.requestProcessor = requestProcessor
    }
    
    // MARK: - IAuthetificationService

    func getAuthentificationTokens(
        authentificationCode: String,
        completion: ((Result<AuthetificationResponse, Error>) -> Void)?
    ) {
        let endpoint = AuthetificationEndpoint.getAuthentificationTokens(authentificationCode: authentificationCode)
        let autoSaveHandler: ((Result<AuthetificationResponse, Error>) -> Void) = { [weak self] result in
            self?.saveTokenIfNeeded(result)
            completion?(result)
        }
        requestProcessor.get().load(endpoint, completion: autoSaveHandler)
    }
    
    func getRefreshedAuthentificationTokens(
        refreshToken: String,
        completion: ((Result<AuthetificationResponse, Error>) -> Void)?
    ) {
        let endpoint = AuthetificationEndpoint.getRefreshedAuthentificationTokens(refreshToken: refreshToken)
        let autoSaveHandler: ((Result<AuthetificationResponse, Error>) -> Void) = { [weak self] result in
            self?.saveTokenIfNeeded(result)
            completion?(result)
        }
        requestProcessor.get().load(endpoint, completion: autoSaveHandler)
    }
    
    private func saveTokenIfNeeded(_ result: Result<AuthetificationResponse, Error>) {
        switch result {
        case .success(let tokens):
            tokenManager.get().saveTokens(tokens)
        case .failure:
            debugPrint("Ошибка запроса получения свежего токена")
            return
        }
    }
}
