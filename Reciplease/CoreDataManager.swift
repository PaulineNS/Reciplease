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
        guard let tasks = try? managedObjectContext.fetch(request) else { return [] }
        return tasks
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func addRecipeToFavorites(name: String, image: String, ingredients: String) {
        let recipe = FavoritesRecipesList(context: managedObjectContext)
        recipe.image = image
        recipe.ingredients = ingredients
        recipe.name = name
        coreDataStack.saveContext()
    }
    
//    func deleteAllIngredients() {
//        ingredients.forEach { managedObjectContext.delete($0) }
//        coreDataStack.saveContext()
//    }
}

