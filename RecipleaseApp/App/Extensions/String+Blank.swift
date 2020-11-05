//
//  String+Blank.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Properties
    
    /// Check if a string contains at least one element
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}
