//
//  AuthetificationViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit
import WebKit

protocol IAuthetificationView: AnyObject {
    func showWebView(with request: URLRequest)
}

class AuthetificationViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Dependecies
    
    private let presenter: IAuthetificationPresenter
    
    // MARK: - Init
    
    init(presenter: IAuthetificationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - UI
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        
        return webView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter.viewDidLoad()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        presenter.webView(webView, didStartProvisionalNavigation: navigation)
    }
}

// MARK: - Private

private extension AuthetificationViewController {
    func setupUI() {
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - IAuthetificationView

extension AuthetificationViewController: IAuthetificationView {
    func showWebView(with request: URLRequest) {
        webView.load(request)
    }
}
