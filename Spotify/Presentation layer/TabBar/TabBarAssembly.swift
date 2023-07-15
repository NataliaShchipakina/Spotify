//
//  TabBarAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

protocol ITabBarAssembly {
    func assembly() -> UIViewController
}

final class TabBarAssembly: ITabBarAssembly {
    
    // MARK: - Dependencies
    
    private let viewControllers: [UIViewController]
    
    // MARK: - Init
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
    
    // MARK: - ITabBarAssembly
    
    func assembly() -> UIViewController {
        TabBarViewController(viewControllers: viewControllers)
    }
}
