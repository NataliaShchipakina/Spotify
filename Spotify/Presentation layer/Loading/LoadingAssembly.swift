//
//  LoadingAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 03.08.2023.
//

import UIKit

protocol ILoadingAssembly {
    func assemble() -> UIViewController
}

final class LoadingAssembly: ILoadingAssembly {
    
    // MARK: - Dependencies
    
    private let welcomeAssembly: Lazy<IWelcomeAssembly>
    private let authetificationService: Lazy<IAuthetificationService>
    private let tabBarAssembly: Lazy<ITabBarAssembly>
    private let tokenManager: Lazy<ITokenManager>
    
    // MARK: - Init
    
    init(
        welcomeAssembly: Lazy<IWelcomeAssembly>,
        authetificationService: Lazy<IAuthetificationService>,
        tabBarAssembly: Lazy<ITabBarAssembly>,
        tokenManager: Lazy<ITokenManager>
    ) {
        self.welcomeAssembly = welcomeAssembly
        self.authetificationService = authetificationService
        self.tabBarAssembly = tabBarAssembly
        self.tokenManager = tokenManager
    }
    
    // MARK: - ILoadingAssembly
    
    func assemble() -> UIViewController {
        let router = LoadingRouter(welcomeAssembly: welcomeAssembly, tabBarAssembly: tabBarAssembly)
        let presenter = LoadingPresenter(
            router: router,
            authetificationService: authetificationService,
            tokenManager: tokenManager
        )
        let viewController = LoadingViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
