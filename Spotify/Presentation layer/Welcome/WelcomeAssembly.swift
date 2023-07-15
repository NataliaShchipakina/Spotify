//
//  WelcomeAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IWelcomeAssembly {
    func assembly() -> UIViewController
}

final class WelcomeAssembly: IWelcomeAssembly {
    
    // MARK: - Dependencies
    
    private let tabBarAssembly: Lazy<ITabBarAssembly>
    
    // MARK: - Init
    
    init(tabBarAssembly: Lazy<ITabBarAssembly>) {
        self.tabBarAssembly = tabBarAssembly
    }
    
    // MARK: - IWelcomeAssembly
        
    func assembly() -> UIViewController {
        let router = WelcomeRouter()
        let presenter = WelcomePresenter(router: router)
        let viewController = WelcomeViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
