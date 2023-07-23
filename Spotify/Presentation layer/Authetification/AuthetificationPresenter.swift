//
//  AuthetificationPresenter.swift
//  Spotify
//
//  Created by Eugene Dudkin on 16.07.2023.
//

import WebKit

protocol IAuthetificationPresenter {
    func viewDidLoad()
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
}

final class AuthetificationPresenter: IAuthetificationPresenter {
    
    // MARK: - Dependencies
    
    private let authetificationService: Lazy<IAuthetificationService>
    private let router: IAuthetificationRouter
    private weak var delegate: AuthetificationDelegate?
    
    weak var view: IAuthetificationView?
    
    // MARK: - Init
    
    init(
        router: IAuthetificationRouter,
        authetificationService: Lazy<IAuthetificationService>,
        delegate: AuthetificationDelegate
    ) {
        self.router = router
        self.authetificationService = authetificationService
        self.delegate = delegate
    }
    
    // MARK: - IAuthetificationPresenter
    
    func viewDidLoad() {
        let clientID = "3c97f978fe294c9a8f333a584e9237c7"
        let clientSecret = "524152b77f8142f9a3a7c0ed4d7325eb"
        let tokenAPIURL = "https://accounts.spotify.com/api/token"
        let redirectURI = "https://github.com/NataliaShchipakina"
        let scopes =
            "user-read-private%20" +
            "playlist-modify-public%20" +
            "playlist-read-private%20" +
            "playlist-modify-private%20" +
            "user-follow-read%20" +
            "user-library-modify%20" +
            "user-library-read%20" +
            "user-read-email"
        
         var signInURL: URL? {
            let base = "https://accounts.spotify.com/authorize"
            let string =
                "\(base)?response_type=code" +
                "&client_id=\(clientID)" +
                "&scope=\(scopes)" +
                "&redirect_uri=\(redirectURI)" +
                "&show_dialog=TRUE"
            
            return URL(string: string)
        }
        
        guard let signInURL else { return }
        view?.showWebView(with: URLRequest(url: signInURL))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        guard
            let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value
        else {
            return
        }

        webView.isHidden = true
        
        authetificationService.get().getAuthentificationTokens(authentificationCode: code) { [weak self] result in
            switch result {
            case .success:
                self?.handleExchandeCodeForTokenResponse(true)
            case .failure:
                self?.handleExchandeCodeForTokenResponse(false)
            }
        }
    }
}

// MARK: - Private

private extension AuthetificationPresenter {
    func handleExchandeCodeForTokenResponse(_ isSuccess: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.router.closeScreen()
            self?.delegate?.handleAuthetificationResponse(isSuccess)
        }
    }
}
