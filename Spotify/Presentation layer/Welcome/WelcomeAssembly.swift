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
    private let authetificationAssembly: Lazy<IAuthetificationAssembly>
    
    // MARK: - Init
    
    init(
        tabBarAssembly: Lazy<ITabBarAssembly>,
        authetificationAssembly: Lazy<IAuthetificationAssembly>
    ) {
        self.tabBarAssembly = tabBarAssembly
        self.authetificationAssembly = authetificationAssembly
    }
    
    // MARK: - IWelcomeAssembly
        
    func assembly() -> UIViewController {
        let router = WelcomeRouter(tabBarAssembly: tabBarAssembly, authetificationAssembly: authetificationAssembly)
        let presenter = WelcomePresenter(router: router)
        let viewController = WelcomeViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
