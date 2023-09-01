//
//  CategoriesRouter.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 29.08.2023.
//

import UIKit

protocol ICategoriesRouter { }

final class CategoriesRouter: ICategoriesRouter {

    // MARK: - Dependencies

    weak var transitionHandler: UIViewController?

    // MARK: - Init

    init() { }

    // MARK: - ICategoriesRouter

}
