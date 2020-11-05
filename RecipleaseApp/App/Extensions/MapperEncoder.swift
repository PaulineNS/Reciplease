//
//  MapperEncoder.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

// MARK: - Properties

protocol MapperEncoder {
    func encode(baseUrl: URL,
                parameters: [(String, Any)]?) -> URL
}

/// Return an URL parameted
extension MapperEncoder {
    func encode(baseUrl: URL,
                parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl,
                                                resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseUrl
        }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key,
                                         value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let urlParameted = urlComponents.url else {
            return baseUrl
        }
        return urlParameted
    }
}
