//
//  IntExtension.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 29/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

extension Int {
    
    // MARK: - Properties
    
    /// Convert Int to Time format
    var convertIntToTime: String {
        let hrs = self / 60
        let min = self % 60
        return hrs > 0 ? String(format: "%1dh%02d", hrs, min) : String(format: "%1dmn", min)
    }
}

