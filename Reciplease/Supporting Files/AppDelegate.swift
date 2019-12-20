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
    lazy var dataBaseStack = DataBaseStack(modelName: "Reciplease")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        dataBaseStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
         dataBaseStack.saveContext()
    }
}

