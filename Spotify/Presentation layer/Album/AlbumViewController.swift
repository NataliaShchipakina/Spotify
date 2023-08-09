//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Album"
        view.backgroundColor = .systemBackground
    }


}
