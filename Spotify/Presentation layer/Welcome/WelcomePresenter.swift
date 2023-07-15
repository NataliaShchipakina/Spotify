//
//  WelcomePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IWelcomePresenter {
    
}

final class WelcomePresenter: IWelcomePresenter {
    
    // MARK: - Dependencies
    
    private let router: IWelcomeRouter
    
    weak var view: IWelcomeView?
    
    // MARK: - Init
    
    init(router: IWelcomeRouter) {
        self.router = router
    }
    
    // MARK: - IWelcomePresenter
}
