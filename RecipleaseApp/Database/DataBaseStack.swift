//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 14/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation
import CoreData

open class DataBaseStack {
    
    // MARK: - Variables
    
    private let modelName: String
    
    // MARK: - Initializer
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
