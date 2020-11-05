//
//  UIViewController+Image.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties

    /// Obtain data from url
    func obtainImageDataFromUrl(stringImageUrl: String) -> Data{
        guard let imageUrl = URL(string: stringImageUrl) else {
            return Data()
        }
        guard let data = try? Data(contentsOf: imageUrl) else {
            return Data()
        }
        return data
    }
}
