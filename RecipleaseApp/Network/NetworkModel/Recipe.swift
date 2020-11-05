//
//  Recipe.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: RecipeClass
}

// MARK: - RecipeClass
struct RecipeClass: Codable {
    let label: String?
    let image: String?
    let url: String?
    let ingredientLines: [String]?
    let totalTime: Int?
}
