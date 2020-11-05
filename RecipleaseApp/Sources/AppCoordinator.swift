//
//  AppCoordinator.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class AppCoordinator {

    // MARK: - Private properties

    private unowned var appDelegate: AppDelegate
    private let context: Context
    private var homeCoordinator: MainCoordinator?

    // MARK: - Initializer

    init(appDelegate: AppDelegate,
         context: Context) {
        self.appDelegate = appDelegate
        self.context = context
    }

    // MARK: - Coordinator

    func start() {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window!.rootViewController = UIViewController()
        appDelegate.window!.makeKeyAndVisible()

        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }
        
        showHome()
    }

    private func showHome() {
        homeCoordinator = MainCoordinator(presenter: appDelegate.window!,
                                          context: context)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.08827573806, green: 0.2311432958, blue: 0.1987672448, alpha: 1)
        UITabBar.appearance().barTintColor = .white
        homeCoordinator?.start()
    }
}
