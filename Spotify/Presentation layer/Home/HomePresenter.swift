//
//  HomePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IHomePresenter {
    
}

final class HomePresenter: IHomePresenter {
    
    // MARK: - Dependencies
    
    private let router: IHomeRouter
    
    weak var view: IHomeView?
    
    // MARK: - Init
    
    init(router: IHomeRouter) {
        self.router = router
    }
    
    // MARK: - IHomePresenter
}
