//
//  LoadingViewController.swift
//  Spotify
//
//  Created by Eugene Dudkin on 03.08.2023.
//

import UIKit

protocol ILoadingView: AnyObject {
    func showViewState(state: LoadingState)
}

enum LoadingState {
    case loading(text: String)
}

final class LoadingViewController: UIViewController {
    
    // MARK: - State
    
    private var currentState: LoadingState?
    
    // MARK: - UI
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")!
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = UIColor(red: 101/255, green: 212/255, blue: 110/255, alpha: 1)
        activity.alpha = 0
        return activity
    }()
    
    private let informLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 101/255, green: 212/255, blue: 110/255, alpha: 1)
        label.alpha = 0
        return label
    }()
    
    // MARK: - Dependecies
    
    private let presenter: ILoadingPresenter
    
    // MARK: - Init
    
    init(presenter: ILoadingPresenter) {
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
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 24/255, green: 20/255, blue: 20/255, alpha: 1)
        view.addSubview(logoImage)
        view.addSubview(activityIndicator)
        view.addSubview(informLabel)
    }
    
    private func setupConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        informLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            informLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 40),
            informLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - ILoadingView

extension LoadingViewController: ILoadingView {
    func showViewState(state newState: LoadingState) {
        switch (currentState, newState) {
        case (nil, .loading(let title)):
            startAnimation(with: title)
        case (.loading, .loading(let newTitle)):
            animateToNewTitle(with: newTitle)
        }
        
        currentState = newState
    }
}

// MARK: - Private

private extension LoadingViewController {
    func startAnimation(with title: String) {
        activityIndicator.alpha = 0
        activityIndicator.startAnimating()
        informLabel.text = title
        
        UIView.animate(withDuration: 2) {
            self.activityIndicator.alpha = 1
            self.informLabel.alpha = 1
        }
    }
    
    func animateToNewTitle(with newTitle: String) {
        UIView.animate(withDuration: 2) {
            self.informLabel.alpha = 0.2
        } completion: { _ in
            self.informLabel.text = newTitle
            UIView.animate(withDuration: 2) {
                self.informLabel.alpha = 1
            }
        }
    }
}
