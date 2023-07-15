//
//  ApplicationAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

final class ApplicationAssembly {
    
    // MARK: - Dependecies
    
    private let dependenciesAssembly: DependenciesAssembly
    
    // MARK: - Init
    
    init(dependenciesAssembly: DependenciesAssembly = DependenciesAssembly()) {
        self.dependenciesAssembly = dependenciesAssembly
    }

    func getRootViewController() -> UIViewController {
        let rootViewController: UIViewController
        
        if AuthManager.shared.isSignedIn {
            AuthManager.shared.refreshIfNeeded(completion: nil)

            rootViewController = dependenciesAssembly.tabBarAssembly.get().assembly()
        } else {
            let welcomeViewController = dependenciesAssembly.welcomeAssembly.get().assembly()
            let navigationViewController = UINavigationController(rootViewController: welcomeViewController)
            navigationViewController.navigationBar.prefersLargeTitles = true
            navigationViewController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            
            rootViewController = navigationViewController
        }
        
        return rootViewController
    }
}
