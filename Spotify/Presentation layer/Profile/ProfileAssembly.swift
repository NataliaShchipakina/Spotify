//
//  ProfileAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IProfileAssembly {
    func assemble() -> UIViewController
}

final class ProfileAssembly: IProfileAssembly {
    
    // MARK: - Dependencies
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - IHomeAssembly
    
    func assemble() -> UIViewController {
        let router = ProfileRouter()
        let presenter = ProfilePresenter(router: router)
        let viewController = ProfileViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
