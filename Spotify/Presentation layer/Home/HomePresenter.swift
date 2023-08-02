//
//  HomePresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import Foundation

protocol IHomePresenter {
    func viewDidLoad()
    func didTapSettingsButton()
}

final class HomePresenter: IHomePresenter {
    
    // MARK: - Dependencies
    
    private let router: IHomeRouter
    private let spotifyService: ISpotifyService
    
    weak var view: IHomeView?
    
    // MARK: - Init
    
    init(router: IHomeRouter, spotifyService: Lazy<ISpotifyService>) {
        self.router = router
        self.spotifyService = spotifyService.get()
    }
    
    // MARK: - IHomePresenter
    
    func viewDidLoad() {
        fetchData()
    }
    
    func didTapSettingsButton() {
        router.showSettingScreen()
    }
}

private extension HomePresenter {
    func fetchData() {
        spotifyService.getRecommendedGenres { [weak self] result in
            self?.handleRecommendationedGenresResult(result)
        }
        
        spotifyService.getFeaturedPlaylists(limit: 50) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
        
        
        view?.showData(viewModels: [])
    }
    
    func handleRecommendationedGenresResult(_ result: Result<RecommendedGenresResponse, Error>) {
        switch result {
        case .success(let model):
            handleGenresResponse(with: model)
        case .failure(let error):
            // view?.showErrorState()
            break
        }
    }
    
    func handleGenresResponse(with model: RecommendedGenresResponse) {
        let genres = model.genres
        var seeds = Set<String>()
        while seeds.count < 5 {
            if let random = genres.randomElement() {
                seeds.insert(random)
            }
        }
        
        spotifyService.getRecommendations(genres: seeds) { [weak self] result  in
            self?.handleRecommendationsResult(result)
        }
    }
    
    func handleRecommendationsResult(_ result: Result<RecommendationsResponse , Error>) {
        
    }
}
