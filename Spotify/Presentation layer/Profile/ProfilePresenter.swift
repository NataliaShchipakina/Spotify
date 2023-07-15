//
//  ProfilePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IProfilePresenter {
    func viewDidLoad()
}

final class ProfilePresenter: IProfilePresenter {
    
    // MARK: - Dependencies
    
    private let router: IProfileRouter
    private let spotifyService: Lazy<ISpotifyService>
    
    weak var view: IProfileView?
    
    // MARK: - Init
    
    init(router: IProfileRouter, spotifyService: Lazy<ISpotifyService>) {
        self.router = router
        self.spotifyService = spotifyService
    }
    
    // MARK: - IProfilePresenter
    
    func viewDidLoad() {
        fetchUserProfile()
    }
}

// MARK: - Private

private extension ProfilePresenter {
    func fetchUserProfile() {
        spotifyService.get().getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self?.view?.showProfile(with: model)
                case .failure:
                    self?.view?.showFailedLoadProfileView()
                }
            }
        }
    }
}
