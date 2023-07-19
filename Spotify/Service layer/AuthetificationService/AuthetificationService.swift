//
//  AuthManager.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import Foundation

protocol IAuthetificationService {
    /// Ссылка для авторизации, после авторизации получаем code
    var signInURL: URL? { get }
    /// Признак авторизованности пользователя
    var isSignedIn: Bool { get }
    /// Обновляем токен если токен просрочен
    /// - Parameter completion: completion handler
    func refreshIfNeeded(completion: ((Bool) -> Void)?)
    func exchandeCodeForToken(code: String, completion: @escaping ((Bool) -> Void))
}

final class AuthetificationService: IAuthetificationService {
    
    // MARK: - Deprecated
    
    @available(*, deprecated, message: "Pls use DI instead")
    static let shared = AuthetificationService(
        storageManager: Lazy(UserDefaultsStorage()),
        authetificationConfig: AuthetificationConfig()
    )
    
    // MARK: Dependencies
    
    private let storageManager: Lazy<IStorageManager>
    private let authetificationConfig: AuthetificationConfig
    
    // MARK: - Init
    
    init(storageManager: Lazy<IStorageManager>, authetificationConfig: AuthetificationConfig) {
        self.storageManager = storageManager
        self.authetificationConfig = authetificationConfig
    }
    
    // MARK: - IAuthetificationService
    
    private var refreshingToken = false
    
    var signInURL: URL? { authetificationConfig.signInURL }
    var isSignedIn: Bool { accessToken != nil }
    
    private var accessToken: String? {
        storageManager.get().get(key: "access_token")
    }
    
    private var refreshToken: String? {
        storageManager.get().get(key: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        storageManager.get().get(key: "expirationDate")
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchandeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ) {
        // Get Token
        guard let url = URL(string: authetificationConfig.tokenAPIURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: authetificationConfig.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = authetificationConfig.clientID+":"+authetificationConfig.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthetificationResponse.self, from: data)
                print("Successfully refreshed")
                self?.saveToken(result: result)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
//    Supplies valid token to be used with API Calls
    public func withValidToken(completion: @escaping(String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            //  Refresh
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        }
        else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        

        guard let refreshToken = self.refreshToken else {
            return
        }
        
        // Refresh the token
        
        guard let url = URL(string: authetificationConfig.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = authetificationConfig.clientID+":"+authetificationConfig.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)",
                         forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.refreshingToken = false
            guard let data = data,
                  error == nil else {
                completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthetificationResponse.self, from: data)
                self?.onRefreshBlocks.forEach { $0(result.access_token) }
                self?.onRefreshBlocks.removeAll()
                self?.saveToken(result: result)
                completion?(true)
            }
            catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
    
    private func saveToken(result: AuthetificationResponse) {
        // Сохраняем accessToken
        storageManager.get().set(key: "access_token", value: result.access_token)
        
        // Сохраняем expirationDate
        let expirationDate = Date().addingTimeInterval(TimeInterval(result.expires_in))
        storageManager.get().set(key: "expirationDate", value: expirationDate)
        
        // Сохраняем refreshToken
        if let refreshToken = result.refresh_token {
            storageManager.get().set(key: "refresh_token", value: refreshToken)
        }
    }
}
