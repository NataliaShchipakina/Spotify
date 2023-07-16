//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol IWelcomeView: AnyObject {
    
}

class WelcomeViewController: UIViewController {
    
    // MARK: - UI
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()
    
    // MARK: - Dependecies
    
    private let presenter: IWelcomePresenter
    
    // MARK: - Init
    
    init(presenter: IWelcomePresenter) {
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50
        )
    }
}

// MARK: - IWelcomeView

extension WelcomeViewController: IWelcomeView {
    
}

// MARK: - Private

private extension WelcomeViewController {
    func setupUI() {
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        presenter.signInButtonDidTap()
    }
}
