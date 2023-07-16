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
        
        if AuthetificationService.shared.isSignedIn {
            AuthetificationService.shared.refreshIfNeeded(completion: nil)

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
