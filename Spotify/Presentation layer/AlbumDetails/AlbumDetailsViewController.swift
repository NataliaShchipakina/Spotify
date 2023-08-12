//
//  AlbumDetailsViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import UIKit


protocol IAlbumView: AnyObject { }

class AlbumDetailsViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let presenter: IAlbumPresenter
    
    init(presenter: IAlbumPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Album"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
        
}

extension AlbumDetailsViewController: IAlbumView {
    
}


