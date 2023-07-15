//
//  SettingsAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol ISettingsAssembly {
    func assemble() -> UIViewController
}

final class SettingsAssembly: ISettingsAssembly {
    
    // MARK: - Dependencies
    
    private let profileAssembly: Lazy<IProfileAssembly>
    
    // MARK: - Init
    
    init(profileAssembly: Lazy<IProfileAssembly>) {
        self.profileAssembly = profileAssembly
    }
    
    // MARK: - ISettingsAssembly
    
    func assemble() -> UIViewController {
        let router = SettingsRouter(profileAssembly: profileAssembly)
        let presenter = SettingsPresenter(router: router)
        let viewController = SettingsViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
