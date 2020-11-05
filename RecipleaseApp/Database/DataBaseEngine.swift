//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 14/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation
import CoreData

final class DataBaseEngine {
    
    // MARK: - Variables
    
    private let dataBaseStack: DataBaseStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoritesRecipes: [FavoritesRecipesList] {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    
    init(dataBaseStack: DataBaseStack) {
        self.dataBaseStack = dataBaseStack
        self.managedObjectContext = dataBaseStack.mainContext
    }
    
    // MARK: - Properties
    
    /// Manage  Favorite Recipes List entities
    func addRecipeToFavorites(recipeItem: RecipeItem) {
        let recipe = FavoritesRecipesList(context: managedObjectContext)
        recipe.image = recipeItem.image
        recipe.ingredients = recipeItem.ingredients
        recipe.name = recipeItem.name
        recipe.recipeUrl = recipeItem.url
        recipe.totalTime = recipeItem.time
        dataBaseStack.saveContext()
    }
    
    /// Delete recipe from favorite thanks to his name
    func deleteRecipeFromFavorite(recipeName: String) {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipeName)
        request.predicate = predicate
        if let objects = try? managedObjectContext.fetch(request) {
            objects.forEach { managedObjectContext.delete($0)}
        }
        dataBaseStack.saveContext()
    }

    /// Delete all favorites recipes
    func deleteAllFavorites() {
        favoritesRecipes.forEach { managedObjectContext.delete($0)}
        dataBaseStack.saveContext()
    }
    
    /// Checking if a recipe is already saved as favorite
    func checkIfRecipeIsInFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipeName)
        guard let recipes = try? managedObjectContext.fetch(request) else { return false }
        if recipes.isEmpty {return false}
        return true
    }
}



