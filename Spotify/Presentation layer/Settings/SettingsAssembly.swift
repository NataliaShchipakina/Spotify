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
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - ISettingsAssembly
    
    func assemble() -> UIViewController {
        let router = SettingsRouter()
        let presenter = SettingsPresenter(router: router)
        let viewController = SettingsViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
