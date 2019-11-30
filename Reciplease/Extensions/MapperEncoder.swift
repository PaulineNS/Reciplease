//
//  MapperEncoder.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 30/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

public protocol MapperEncoder {
    func encode(baseUrl: URL, parameters: [(String, Any?)]?) -> URL
}

public extension MapperEncoder {
    func encode(baseUrl: URL, parameters: [(String, Any?)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else {return baseUrl}
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let urlParameted = urlComponents.url else {return baseUrl}
        return urlParameted
        }
    }
