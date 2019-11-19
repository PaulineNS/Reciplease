//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Pauline Nomballais on 19/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//
@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    //MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests
    
    func testAddIngredientMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createIngredient(name: "chicken")
        XCTAssertTrue(!coreDataManager.ingredients.isEmpty)
        XCTAssertTrue(coreDataManager.ingredients.count == 1)
        XCTAssertTrue(coreDataManager.ingredients[0].name! == "chicken")
    }
    
    func testDeleteAllIngredientsMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createIngredient(name: "chicken")
        coreDataManager.deleteAllIngredients()
        XCTAssertTrue(coreDataManager.ingredients.isEmpty)
    }
}
