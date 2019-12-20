//
//  MockCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Pauline Nomballais on 19/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//
import Reciplease
import Foundation
import CoreData

final class MockDataBaseStack: DataBaseStack {
    
    // MARK: - Initializer
    
    convenience init() {
        self.init(modelName: "Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
