//
//  ViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol IHomeView: AnyObject {
    
}

class HomeViewController: UIViewController {
    
    // MARK: - Dependecies
    
    private let presenter: IHomePresenter
    
    // MARK: - Init
    
    init(presenter: IHomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(didTapSettings)
        )
    }

    @objc func didTapSettings() {
        presenter.didTapSettingsButton()
    }
}

// MARK: - IHomeView

extension HomeViewController: IHomeView {
    
}
