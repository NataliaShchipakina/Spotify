//
//  PlaylistRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 10.08.2023.
//

import UIKit

protocol IPlaylistRouter {
    func showActivityViewController(with url: URL)
}

final class PlaylistRouter: IPlaylistRouter {
    
    // MARK: - Dependencies
    
    weak var transitionHandler: UIViewController?
    
    // MARK: - Init
    
    init() { }
    
    // MARK: - IPlaylistRouter
    
    func showActivityViewController(with url: URL) {
        let vc = UIActivityViewController(
            activityItems: [url],
            applicationActivities: []
        )
        transitionHandler?.present(vc, animated: true)
    }
}
