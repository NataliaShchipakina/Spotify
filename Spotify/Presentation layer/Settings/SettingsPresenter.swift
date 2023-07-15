//
//  SettingsPresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol ISettingsPresenter {
    func profileButtonDidTap()
}

final class SettingsPresenter: ISettingsPresenter {
    
    // MARK: - Dependencies
    
    private let router: ISettingsRouter
    
    weak var view: ISettingsView?
    
    // MARK: - Init
    
    init(router: ISettingsRouter) {
        self.router = router
    }
    
    // MARK: - ISettingsPresenter
    
    func profileButtonDidTap() {
        router.showProfileScreen()
    }
}
