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
        guard let url = authetificationService.get().signInURL else { return }        
        view?.showWebView(with: URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        guard
            let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value
        else {
            return
        }

        webView.isHidden = true
        
        authetificationService.get().exchandeCodeForToken(code: code) { [weak self] isSuccess in
            self?.handleExchandeCodeForTokenResponse(isSuccess)
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
