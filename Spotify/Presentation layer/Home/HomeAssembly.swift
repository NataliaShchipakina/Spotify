//
//  HomeAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol IHomeAssembly {
    func assemble() -> UIViewController
}

final class HomeAssembly: IHomeAssembly {
    
    // MARK: - Dependencies
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - IHomeAssembly
    
    func assemble() -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter(router: router)
        let viewController = HomeViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
