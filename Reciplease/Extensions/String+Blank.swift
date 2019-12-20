//
//  String+Blank.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 20/12/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Properties
    
    /// Check if a string contains at least one element
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}
