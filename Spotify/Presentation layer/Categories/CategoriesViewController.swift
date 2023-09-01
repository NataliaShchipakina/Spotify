//
//  CategoriesViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoriesView: AnyObject { }

final class CategoriesViewController: UIViewController {
    
    // MARK: - UI

    // MARK: - Dependecies
    
    private let presenter: ICategoriesPresenter
    
    // MARK: - Init
    
    init(presenter: ICategoriesPresenter) {
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
    }
    
    private func setupUI() { }

    private func setupConstraints() { }
}

// MARK: - ICategoriesView

extension CategoriesViewController: ICategoriesView {
    func reloadData() {    }
}
