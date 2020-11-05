//
//  Context.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

final class Context {

    // MARK: - Properties

    let client: HTTPClientType
    let engine: HTTPEngineType
    let requestCancellation: RequestCancellationToken
    let dataBaseStack: DataBaseStack
    let dataBaseEngine: DataBaseEngine

    // MARK: - Initializer

    private init() {
        self.engine = HTTPEngine()
        self.client = HTTPClient(engine: engine)
        self.requestCancellation = RequestCancellationToken()
        self.dataBaseStack = DataBaseStack(modelName: "Reciplease")
        self.dataBaseEngine = DataBaseEngine(dataBaseStack: dataBaseStack)
    }

    // MARK: - Build

    class func build() -> Context {
        return Context()
    }

}
