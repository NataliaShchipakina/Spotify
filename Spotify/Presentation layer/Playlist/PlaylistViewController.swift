//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol IPlaylistView: AnyObject { }

class PlaylistViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let presenter: IPlaylistPresenter
    
    
    init(presenter: IPlaylistPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        view.backgroundColor = .systemBackground
    }
}

extension PlaylistViewController: IPlaylistView { }
