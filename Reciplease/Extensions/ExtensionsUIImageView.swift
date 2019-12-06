//
//  ExtensionsUIImageView.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 19/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - Properties

    /// Load url on UIImageview
    func load(url: URL) {
        guard let data = try? Data(contentsOf: url) else {return}
        guard let image = UIImage(data: data) else {return}
        DispatchQueue.main.async {
            self.image = image
        }
    }
}

