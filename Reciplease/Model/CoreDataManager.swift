//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 14/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoritesRecipes: [FavoritesRecipesList] {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        //request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    func addRecipeToFavorites(name: String, image: Data, ingredientsDescription: String, recipeUrl: String, time: String) {
        let recipe = FavoritesRecipesList(context: managedObjectContext)
        recipe.image = image
        recipe.ingredients = ingredientsDescription
        recipe.name = name
        recipe.recipeUrl = recipeUrl
        recipe.totalTime = time
        coreDataStack.saveContext()
    }
    
    func deleteRecipeFromFavorite(recipeName: String) {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", recipeName)
        request.predicate = predicate
        if let objects = try? managedObjectContext.fetch(request) {
            objects.forEach { managedObjectContext.delete($0)}
        }
        coreDataStack.saveContext()
    }

    func deleteAllFavorites() {
        favoritesRecipes.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    func checkIfRecipeIsAlreadyFavorite(recipeName: String) -> Bool {
        let request: NSFetchRequest<FavoritesRecipesList> = FavoritesRecipesList.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", recipeName)
        guard let recipes = try? managedObjectContext.fetch(request) else { return false }
        if recipes.isEmpty {return false}
        return true
    }
}



