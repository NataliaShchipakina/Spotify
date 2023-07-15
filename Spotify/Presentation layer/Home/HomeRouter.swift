//
//  HomeRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IHomeRouter {
    func showSettingScreen()
}

final class HomeRouter: IHomeRouter {
    
    // MARK: - Dependencies
    
    private let settingAssembly: Lazy<ISettingsAssembly>
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init(settingAssembly: Lazy<ISettingsAssembly>) {
        self.settingAssembly = settingAssembly
    }
    
    // MARK: - IHomeRouter
    
    func showSettingScreen() {
        let settingsViewController = settingAssembly.get().assemble()
        settingsViewController.navigationItem.largeTitleDisplayMode = .never
        
        transitionHandler?.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
