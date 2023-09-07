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
    
    private let userService: Lazy<IUserService>
    
    // MARK: - Init
    
    init(userService: Lazy<IUserService>) {
        self.userService = userService
    }
    
    // MARK: - IHomeAssembly
    
    func assemble() -> UIViewController {
        let router = ProfileRouter()
        let presenter = ProfilePresenter(router: router, userService: userService)
        let viewController = ProfileViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
