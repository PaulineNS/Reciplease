//
//  UIViewController+NavigationBar.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 20/12/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties

    /// Update the Navigation Bar with an icon
    func updateTheNavigationBar(navBarItem: UINavigationItem){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = #imageLiteral(resourceName: "chief")
        imageView.image = image
        navBarItem.titleView = imageView
    }
}
