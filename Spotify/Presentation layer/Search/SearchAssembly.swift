//
//  SearchAssembly.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ISearchAssembly {
    func assembly() -> UIViewController
}

final class SearchAssembly: ISearchAssembly {
    
    // MARK: - Dependencies
    

    
    // MARK: - Init
    

    
    // MARK: - IWelcomeAssembly
        
    func assembly() -> UIViewController {
        let router = SearchRouter()
        let presenter = SearchPresenter(router: router)
        let viewController = SearchViewController(presenter: presenter)
        
        return viewController
    }
}
