//
//  WelcomeRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IWelcomeRouter {
    func showAuthetificationScreen(delegate: AuthetificationDelegate)
    func showMainTabBarScreen()
    func showFailedAuthetificatioAlert()
}

final class WelcomeRouter: IWelcomeRouter {
    
    // MARK: - Dependencies
    
    private let tabBarAssembly: Lazy<ITabBarAssembly>
    private let authetificationAssembly: Lazy<IAuthetificationAssembly>
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(tabBarAssembly: Lazy<ITabBarAssembly>, authetificationAssembly: Lazy<IAuthetificationAssembly>) {
        self.authetificationAssembly = authetificationAssembly
        self.tabBarAssembly = tabBarAssembly
    }
    
    // MARK: - IWelcomeRouter
    
    func showAuthetificationScreen(delegate: AuthetificationDelegate) {
        let authetificationViewController = authetificationAssembly.get().assembly(delegate: delegate)
        authetificationViewController.navigationItem.largeTitleDisplayMode = .never
        
        transitionHandler?.navigationController?.pushViewController(authetificationViewController, animated: true)
    }
    
    func showMainTabBarScreen() {
        let tabBarViewController = tabBarAssembly.get().assembly()
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        transitionHandler?.present(tabBarViewController, animated: true)
    }
    
    func showFailedAuthetificatioAlert() {
        let alert = UIAlertController(
            title: "Oops",
            message: "Something went wrong when signing in",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        transitionHandler?.present(alert, animated: true)
    }
}
