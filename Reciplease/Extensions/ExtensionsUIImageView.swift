//
//  ExtensionsUIImageView.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 19/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

// load url on UIImageview
extension UIImageView {
    func load(url: URL) {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
