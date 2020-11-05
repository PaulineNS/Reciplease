//
//  HTTPClient.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType: String {
    case GET
    case POST
}

enum Result<T> {
    case success(value: T)
    case error(error: Error)
}

enum HTTPClientError: Error {
    case unableToParseToJSON(Data)
    case random
    case missingData
    case generic(Error)
}

protocol HTTPClientType: class {
    func request<T: Decodable>(
                    url: URL,
                    completion: @escaping (Result<T>) -> Void
    )
}

final class HTTPClient: HTTPClientType {

    // MARK: - Properties

    private let engine: HTTPEngineType
    private let jsonDecoder: JSONDecoder

    // MARK: - Init

    init(engine: HTTPEngineType) {
        self.engine = engine
        self.jsonDecoder = JSONDecoder()
    }

    // MARK: - HTTPClientType protocol

    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T>) -> Void
    ) {
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.error {
                completion(.error(error: error))
            } else if let data = response.data {
                guard let recipes = try? self.jsonDecoder.decode(T.self, from: data) else { return }
                completion(.success(value: recipes))
            } else {
                completion(.error(error: HTTPClientError.missingData))
            }
        }
    }

    private func decodeJSON<T: Decodable>(
        data: Data,
        completion: @escaping (T) -> Void
    ) {
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            print("Decoder was unable to decode: \(T.self)")
            return
        }
        completion(decodedData)
    }
}
