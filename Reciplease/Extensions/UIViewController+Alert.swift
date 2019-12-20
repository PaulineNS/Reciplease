//
//  UIViewController+Alert.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 20/12/2019.
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
}
