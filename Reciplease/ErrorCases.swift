//
//  ErrorCases.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

/// Enumeration of error cases
enum NetworkError: Error {
    case badUrl
    case invalidData
    case network
}
