//
//  SearchRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import UIKit

protocol ISearchRouter {
}

final class SearchRouter: ISearchRouter {
    
    // MARK: - Dependencies
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - ISearchRouter
    
}

