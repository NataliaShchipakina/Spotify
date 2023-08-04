//
//  ApplicationAssembly.swift
//  Spotify
//
//  Created by Eugene Dudkin on 15.07.2023.
//

import UIKit

final class ApplicationAssembly {
    
    // MARK: - Dependecies
    
    private let dependenciesAssembly: IDependenciesAssembly
    
    // MARK: - Init
    
    init(dependenciesAssembly: IDependenciesAssembly = DependenciesAssembly()) {
        self.dependenciesAssembly = dependenciesAssembly
    }

    func getRootViewController() -> UIViewController {
        dependenciesAssembly.loadingAssembly.get().assemble()
    }
}
