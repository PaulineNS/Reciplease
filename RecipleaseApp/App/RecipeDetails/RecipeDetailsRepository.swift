//
//  RecipeDetailsRepository.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 04/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

protocol RecipeDetailsRepositoryType: class {
    
    func checkIfRecipeIsInFavorite(recipeName: String) -> Bool
    func deleteRecipeFromFavorites(recipeName: String)
    func addRecipeToFavorites(recipeItem: RecipeItem)
}

final class RecipeDetailsRepository: RecipeDetailsRepositoryType {
    
    // MARK: - Properties

    private let dataBaseEngine: DataBaseEngine
    
    // MARK: - Init

    init(dataBaseEngine: DataBaseEngine) {
        self.dataBaseEngine = dataBaseEngine
    }
    
    // MARK: - RecipeDetailsRepositoryType

    func checkIfRecipeIsInFavorite(recipeName: String) -> Bool {
        guard dataBaseEngine.checkIfRecipeIsInFavorite(recipeName: recipeName) == true else {
            return false
        }
        return true
    }
    
    func addRecipeToFavorites(recipeItem: RecipeItem) {
        dataBaseEngine.addRecipeToFavorites(recipeItem: recipeItem)        
    }
    
    func deleteRecipeFromFavorites(recipeName: String) {
        dataBaseEngine.deleteRecipeFromFavorite(recipeName: recipeName)
    }
}
