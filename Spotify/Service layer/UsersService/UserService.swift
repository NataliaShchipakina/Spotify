//
//  UserService.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.09.2023.
//

import Foundation

protocol IUserService {
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void)
}

final class UserService: IUserService {
    
    // MARK: - Dependencies
    
    private let requestProcessor: IRequestProcessor
    
    // MARK: - Init
    
    init(requestProcessor: Lazy<IRequestProcessor>) {
        self.requestProcessor = requestProcessor.get()
    }
    
    // MARK: - IUserService
    
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        let endpoint = UsersEndpoint.getCurrentUserProfile
        requestProcessor.load(endpoint, completion: completion)
    }
}
