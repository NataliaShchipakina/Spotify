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
        fetchData()
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
    
    private func fetchData() {
        SpotifyService.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                SpotifyService.shared.getRecommendations(genres: seeds) { _  in
                    
                }
                
            case .failure(let error): break

            }
        }
    }
    

    @objc func didTapSettings() {
//        let vc = SettingsViewController()
//        vc.title = "Settings"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - IHomeView

extension HomeViewController: IHomeView {
    
}
