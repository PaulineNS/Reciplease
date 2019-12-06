//
//  ControllerExtension.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties
    
    /// Alert
    func presentAlert(message: String){
        let alertVC = UIAlertController(title: "Oups", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    /// Update the Navigation Bar with an icon
    func updateTheNavigationBar(navBarItem: UINavigationItem){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = #imageLiteral(resourceName: "chief")
        imageView.image = image
        navBarItem.titleView = imageView
    }
    
    /// Obtain data from url
    func obtainImageDataFromUrl(stringImageUrl: String) -> Data{
        guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
        guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
        return data
    }
}
