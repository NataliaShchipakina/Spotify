//
//  ApplicationAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

final class ApplicationAssembly {
    
    // MARK: - Dependecies
    
    private let dependenciesAssembly: IDependenciesAssembly
    
    // MARK: - Init
    
    init(dependenciesAssembly: IDependenciesAssembly = DependenciesAssembly()) {
        self.dependenciesAssembly = dependenciesAssembly
    }

    func getRootViewController() -> UIViewController {
        let rootViewController: UIViewController
        
        let tokenManager = dependenciesAssembly.tokenManager.get()
        let accessToken = tokenManager.getAccessToken()
        let refreshToken = tokenManager.getRefreshToken()
        
        if accessToken != nil, let refreshToken {
            dependenciesAssembly.authetificationService.get().getRefreshedAuthentificationTokens(refreshToken: refreshToken, completion: nil)

            rootViewController = dependenciesAssembly.tabBarAssembly.get().assembly()
        } else {
            let welcomeViewController = dependenciesAssembly.welcomeAssembly.get().assembly()
            let navigationViewController = UINavigationController(rootViewController: welcomeViewController)
            
            rootViewController = navigationViewController
        }
        
        return rootViewController
    }
}
