//
//  AlbumDetailsViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 09.08.2023.
//

import UIKit


protocol IAlbumView: AnyObject {
    func configure(with model: AlbumDetailResponse)
}

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
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        presenter.viewDidLoad()
    }
        
}

extension AlbumDetailsViewController: IAlbumView {
    func configure(with model: AlbumDetailResponse) {
        title = model.name
    }
}
