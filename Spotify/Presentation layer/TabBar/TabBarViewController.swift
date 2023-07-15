//
//  TavBarViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Dependencies
    
    let rawViewControllers: [UIViewController]
    
    // MARK: - Init

    init(viewControllers: [UIViewController]) {
        self.rawViewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
}

// MARK: - Private

private extension TabBarViewController {
    func setupTabs() {
        guard rawViewControllers.count == 3 else { return }
        
        let vc1 = rawViewControllers[0]
        let vc2 = rawViewControllers[1]
        let vc3 = rawViewControllers[2]
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        rawViewControllers.forEach { $0.navigationItem.largeTitleDisplayMode = .always }
        let navigationsViewControllers = rawViewControllers.map { UINavigationController(rootViewController: $0) }
        navigationsViewControllers.forEach { $0.navigationBar.tintColor = .label }
        navigationsViewControllers.forEach { $0.navigationBar.prefersLargeTitles = true }

        navigationsViewControllers[0].tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        navigationsViewControllers[1].tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        
        navigationsViewControllers[2].tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "music.note.list"),
            tag: 2
        )
        
        setViewControllers(navigationsViewControllers, animated: false)
    }
}
