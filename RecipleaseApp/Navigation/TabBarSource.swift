//
//  TabBarSource.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case search = 0
    case favorite
}

protocol TabBarSourceType {
    var items: [UINavigationController] { get set }
}

final class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil,
                               bundle: nil),
        UINavigationController(nibName: nil,
                               bundle: nil)]
        
    init() {
        self[.search].tabBarItem = UITabBarItem(tabBarSystemItem: .search,
                                                tag: 0)
        self[.favorite].tabBarItem = UITabBarItem(tabBarSystemItem: .favorites,
                                                  tag: 1)
    }
}

extension TabBarSourceType {
    
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exists")
            }
            return items[item.rawValue]
        }
    }
    
}
