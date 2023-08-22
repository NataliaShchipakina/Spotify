//
//  SettingsRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol ISettingsRouter {
    func showProfileScreen()
}

final class SettingsRouter: ISettingsRouter {
    
    // MARK: - Dependencies
    
    private let profileAssembly: Lazy<IProfileAssembly>
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(profileAssembly: Lazy<IProfileAssembly>) {
        self.profileAssembly = profileAssembly
    }
    
    // MARK: - ISettingsRouter
    
    func showProfileScreen() {
        let profileViewController = profileAssembly.get().assemble()
        transitionHandler?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
