//
//  ControllerExtension.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

//MARK: ALERT
extension UIViewController {
    
    func presentAlert(message: String){
        let alertVC = UIAlertController(title: "Oups", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return present(alertVC, animated: true, completion: nil)
    }
    
}
