//
//  HomeCoordinator.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class MainCoordinator: NSObject, UITabBarControllerDelegate {

    // MARK: - Properties

    private let presenter: UIWindow
    private let tabBarController: UITabBarController
    private var tabBarSource: TabBarSourceType = TabBarSource()
    private var searchCoordinator: SearchCoordinator?
    private var favoriteRecipesCoordinator: FavoriteCoordinator?
    private let screens: Screens

    // MARK: - Init

    init(presenter: UIWindow,
         context: Context) {
        self.presenter = presenter
        self.screens = Screens(context: context)
        tabBarController = UITabBarController(nibName: nil,
                                              bundle: nil)
        tabBarController.viewControllers = tabBarSource.items
        tabBarController.selectedViewController = tabBarSource[.search]
        super.init()
        tabBarController.delegate = self

    }

    // MARK: - Coordinator

    func start() {
        presenter.rootViewController = tabBarController
        showSearchView()
    }
    
    // MARK: - Search

    private func showSearchView() {
        searchCoordinator = SearchCoordinator(presenter: tabBarSource[.search],
                                              screens: screens)
        searchCoordinator?.start()
    }
    
    // MARK: - Favorite

    private func showFavoriteView() {
        favoriteRecipesCoordinator = FavoriteCoordinator(presenter: tabBarSource[.favorite],
                                                         screens: screens)
        favoriteRecipesCoordinator?.start()
    }
}

extension MainCoordinator {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < tabBarSource.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("error")
        }
        
        switch item {
        case .search:
            showSearchView()
        case .favorite:
            showFavoriteView()
        }
    }
}
