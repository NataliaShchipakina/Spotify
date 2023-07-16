//
//  AuthetificationRouter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 16.07.2023.
//

import UIKit

protocol IAuthetificationRouter {
    func closeScreen()
}

final class AuthetificationRouter: IAuthetificationRouter {
    
    // MARK: - Dependencies
        
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - IAuthetificationRouter
    
    func closeScreen() {
        transitionHandler?.navigationController?.popToRootViewController(animated: true)
    }
}
