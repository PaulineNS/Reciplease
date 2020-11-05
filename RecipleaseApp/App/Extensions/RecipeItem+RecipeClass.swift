//
//  RecipeItem+RecipeClass.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

// MARK: - Init RecipeItem with RecipeClasss

extension RecipeItem {
    init?(recipe: RecipeClass) {
        guard let name = recipe.label,
              let imageName = recipe.image,
              let url = recipe.url,
              let ingredients = recipe.ingredientLines
        else {
            return nil
        }
        guard let imageUrl = URL(string: imageName) else {return nil}
        guard let data = try? Data(contentsOf: imageUrl) else {return nil}
        self.name = name
        self.image = data
        self.url = url
        self.ingredients = "●" + " " + ingredients.joined(separator: "\n" + "●" + " ")
        self.time = recipe.totalTime?.convertIntToTime ?? ""
    }
}
