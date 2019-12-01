//
//  StringExtension.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 14/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

extension String {
    //Check if a string contains at least one element
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
    
    var convertStringToTime: String {
        let hrs = Int(self)! / 60
        let min = Int(self)! % 60
        return hrs > 0 ? String(format: "%1dh%02d", hrs, min) : String(format: "%1dmn", min)
    }
}
