//
//  PlaylistRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import UIKit

protocol IPlaylistRouter {
}

final class PlaylistRouter: IPlaylistRouter {
    
    // MARK: - Dependencies
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - IPlaylistRouter
    
}
