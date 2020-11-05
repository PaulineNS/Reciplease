//
//  RecipesRepository.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 04/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

protocol RecipesRepositoryType: class {
    
    func getRecipes(callback: @escaping (Result<[RecipeItem]>) -> Void)

}

final class RecipesRepository: RecipesRepositoryType {
    
    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine
    
    // MARK: - Init

    init(dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }
    
    // MARK: - RecipesRepositoryType

    func getRecipes(callback: @escaping (Result<[RecipeItem]>) -> Void) {
            fetchPersistenceDevices(callback: callback)
    }
    
    private func fetchPersistenceDevices(callback: @escaping (Result<[RecipeItem]>) -> Void) {
        let recipes = dataBaseEngine.favoritesRecipes
        let recipeItems = recipes.compactMap {
            RecipeItem(recipe: $0)
        }
        callback(.success(value: recipeItems))
    }
    
}
