//
//  ProfilePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IProfilePresenter {
    
}

final class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Dependencies
    
    private let router: IProfileRouter
    
    weak var view: IProfileView?
    
    // MARK: - Init
    
    init(router: IProfileRouter) {
        self.router = router
    }
    
    // MARK: - IProfilePresenter
}
