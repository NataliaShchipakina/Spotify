//
//  WelcomePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IWelcomePresenter {
    func signInButtonDidTap()
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
    
    func signInButtonDidTap() {
        router.showAuthetificationScreen(delegate: self)
    }
}

extension WelcomePresenter: AuthetificationDelegate {
    func handleAuthetificationResponse(_ isSuccess: Bool) {
        if isSuccess {
            router.showMainTabBarScreen()
        } else {
            router.showFailedAuthetificatioAlert()
        }
    }
}
