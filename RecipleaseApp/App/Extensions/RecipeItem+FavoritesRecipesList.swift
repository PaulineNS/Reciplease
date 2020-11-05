//
//  RecipeItem+FavoritesRecipesList.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 05/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

// MARK: - Init RecipeItem with FavoritesRecipesList

extension RecipeItem {
    init?(recipe: FavoritesRecipesList) {
        guard let name = recipe.name,
              let imageName = recipe.image,
              let url = recipe.recipeUrl,
              let ingredients = recipe.ingredients,
              let time = recipe.totalTime else {
            return nil
        }
        self.name = name
        self.image = imageName
        self.url = url
        self.ingredients = ingredients
        self.time = time
    }
}
