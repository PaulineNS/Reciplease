//
//  UIViewController+Image.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 20/12/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Properties

    /// Obtain data from url
    func obtainImageDataFromUrl(stringImageUrl: String) -> Data{
        guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
        guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
        return data
    }
}
