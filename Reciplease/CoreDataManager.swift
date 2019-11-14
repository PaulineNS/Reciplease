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
    
    var ingredients: [IngredientList] {
        let request: NSFetchRequest<IngredientList> = IngredientList.fetchRequest()
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
    
    func createIngredient(name: String) {
        let ingredient = IngredientList(context: managedObjectContext)
        ingredient.name = name
        coreDataStack.saveContext()
    }
    
    func deleteAllIngredients() {
        ingredients.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}

