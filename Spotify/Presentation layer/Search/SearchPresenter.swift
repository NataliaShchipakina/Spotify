//
//  SearchPresenter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import Foundation

protocol ISearchPresenter {

}

final class SearchPresenter: ISearchPresenter {
    
    // MARK: - Dependencies
    
    private let router: ISearchRouter
    
    weak var view: ISearchView?
    
    // MARK: - Init
    
    init(router: ISearchRouter) {
        self.router = router
    }
    
    // MARK: - IWelcomePresenter

}

