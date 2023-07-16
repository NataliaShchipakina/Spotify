//
//  AuthetificationAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 16.07.2023.
//

import UIKit

protocol IAuthetificationAssembly {
    func assembly(delegate: AuthetificationDelegate) -> UIViewController
}

protocol AuthetificationDelegate: AnyObject {
    func handleAuthetificationResponse(_ isSuccess: Bool)
}

final class AuthetificationAssembly: IAuthetificationAssembly {
    
    // MARK: - Dependencies
    
    private let authetificationService: Lazy<IAuthetificationService>
    
    // MARK: - Init
    
    init(authetificationService: Lazy<IAuthetificationService>) {
        self.authetificationService = authetificationService
    }
    
    // MARK: - IAuthetificationAssembly
        
    func assembly(delegate: AuthetificationDelegate) -> UIViewController {
        let router = AuthetificationRouter()
        let presenter = AuthetificationPresenter(
            router: router,
            authetificationService: authetificationService,
            delegate: delegate
        )
        let viewController = AuthetificationViewController(presenter: presenter)
        
        router.transitionHandler = viewController
        presenter.view = viewController

        return viewController
    }
}
