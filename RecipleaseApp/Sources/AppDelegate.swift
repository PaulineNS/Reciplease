//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 21/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var context: Context!
    private var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        context = Context.build()
        coordinator = AppCoordinator(appDelegate: self,
                                     context: context)
        coordinator.start()
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        context.dataBaseStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        context.dataBaseStack.saveContext()
    }
}

