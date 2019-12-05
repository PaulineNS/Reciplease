//
//  Recipe.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

/// MARK: - Recipe
struct Recipe: Decodable {
    let q: String?
    let to: Int?
    let count: Int?
    let hits: [Hit]?
}

/// MARK: - Hit
struct Hit: Decodable {
    let recipe: RecipeClass?
}

/// MARK: - RecipeClass
struct RecipeClass: Decodable {
    let label: String?
    let image: String?
    let url: String?
    let ingredientLines: [String]?
    let totalTime: Int?
}

/// MARK: - RecipeClass
struct RecipeClassRepresentable {
    let label: String?
    let image: Data?
    let url: String?
    let ingredientLines: String?
    let totalTime: String?
}
