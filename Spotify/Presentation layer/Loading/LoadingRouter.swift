//
//  LoadingRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 03.08.2023.
//

import UIKit

protocol ILoadingRouter {
    func showWelcomeScreen()
    func showTabBarScreen()
}

final class LoadingRouter: ILoadingRouter {
    
    // MARK: - Dependencies
    
    private let welcomeAssembly: Lazy<IWelcomeAssembly>
    private let tabBarAssembly: Lazy<ITabBarAssembly>

    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(welcomeAssembly: Lazy<IWelcomeAssembly>, tabBarAssembly: Lazy<ITabBarAssembly>) {
        self.welcomeAssembly = welcomeAssembly
        self.tabBarAssembly = tabBarAssembly
    }
    
    // MARK: - ILoadingRouter
    
    func showWelcomeScreen() {
        let welcomeController = welcomeAssembly.get().assembly()
        welcomeController.modalPresentationStyle = .fullScreen
        welcomeController.modalTransitionStyle = .flipHorizontal
        transitionHandler?.present(welcomeController, animated: true)
    }
    
    func showTabBarScreen() {
        let tabBarController = tabBarAssembly.get().assembly()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .flipHorizontal
        transitionHandler?.present(tabBarController, animated: true)
    }
}
