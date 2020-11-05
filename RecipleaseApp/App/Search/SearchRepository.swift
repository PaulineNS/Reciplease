//
//  SearchRepository.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

protocol SearchRepositoryType: class {
    
    func getRecipes(url: URL,
                    callback: @escaping (Result<[RecipeItem]>) -> Void,
                    error: @escaping (String) -> Void)
}

final class SearchRepository: SearchRepositoryType {
    
    // MARK: - Properties

    private let networkClient: HTTPClientType
    private let dataBaseEngine: DataBaseEngine
    private let token = RequestCancellationToken()

    // MARK: - Init

    init(networkClient: HTTPClientType,
        dataBaseEngine: DataBaseEngine) {
        self.networkClient = networkClient
        self.dataBaseEngine = dataBaseEngine
    }
    
    // MARK: - SearchRepositoryType

    func getRecipes(url: URL,
                    callback: @escaping (Result<[RecipeItem]>) -> Void,
                    error: @escaping (String) -> Void) {
        executeNetworkRequest(url: url,
                              callback: callback,
                              error: error)
    }
    
    // MARK: - Private Methods

    private func executeNetworkRequest(url: URL,
                                       callback: @escaping (Result<[RecipeItem]>) -> Void,
                                       error: @escaping (String) -> Void) {
        networkClient.request(url: url) { (result: Result<Recipe>) in
            switch result {
            case .success(let response):
                let recipeItems = response
                    .hits
                    .compactMap {
                        RecipeItem(recipe: $0.recipe) }
                callback(.success(value: recipeItems))
            case .error(error: let alert):
                error(alert.localizedDescription)
            }
        }
    }
}
