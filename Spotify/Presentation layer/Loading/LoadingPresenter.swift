//
//  LoadingPresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 03.08.2023.
//

import Foundation

protocol ILoadingPresenter {
    func viewDidAppear()
}

final class LoadingPresenter: ILoadingPresenter {
    
    // MARK: - Dependencies
    
    private let router: ILoadingRouter
    private let authetificationService: Lazy<IAuthetificationService>
    private let tokenManager: Lazy<ITokenManager>
    
    weak var view: ILoadingView?
    
    // MARK: - Init
    
    init(
        router: ILoadingRouter,
        authetificationService: Lazy<IAuthetificationService>,
        tokenManager: Lazy<ITokenManager>
    ) {
        self.router = router
        self.authetificationService = authetificationService
        self.tokenManager = tokenManager
    }
    
    // MARK: - ILoadingPresenter
    
    func viewDidAppear() {
        checkToken()
    }
}

// MARK: Private

private extension LoadingPresenter {
    func checkToken() {
        if let refreshToken = tokenManager.get().getRefreshToken() {
            tryRefreshToken(refreshToken)
        } else {
            self.router.showWelcomeScreen()
        }
    }
    
    func tryRefreshToken(_ refreshToken: String) {
        view?.showViewState(state: .loading(text: "Пробуем обновить токен"))
        
        authetificationService.get().getRefreshedAuthentificationTokens(
            refreshToken: refreshToken) { [weak self] refreshCompletion in
                DispatchQueue.main.async {
                    self?.handleRefreshCompletion(refreshToken: refreshToken, refreshCompletion: refreshCompletion)
                }
            }
    }
    
    func handleRefreshCompletion(refreshToken: String, refreshCompletion: Result<AuthetificationResponse, Error>) {
        switch refreshCompletion {
        case .success:
            router.showTabBarScreen()
        case .failure:
            router.showWelcomeScreen()
        }
    }
}
