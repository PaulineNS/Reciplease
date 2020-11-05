//
//  HTTPEngine.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

typealias HTTPCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalideURLResponse
}

protocol HTTPEngineType {
    func send(request: URLRequest,
              cancelledBy token: RequestCancellationToken,
              callback: @escaping HTTPCompletionHandler)
}

final class HTTPEngine: HTTPEngineType {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Init

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    // MARK: - HTTPEngineType protocol

    func send(request: URLRequest,
              cancelledBy token: RequestCancellationToken,
              callback: @escaping HTTPCompletionHandler) {
        let task = session.dataTask(with: request) { (data, urlResponse, _) in
            if urlResponse != nil, let httpUrlResponse = urlResponse as? HTTPURLResponse {
                callback(data, httpUrlResponse, nil)
            } else {
                callback(data, nil, URLSessionEngineError.invalideURLResponse)
            }
        }
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}
