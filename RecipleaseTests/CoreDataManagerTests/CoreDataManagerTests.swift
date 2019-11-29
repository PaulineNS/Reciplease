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
    
    func testAddRecipeToFavoritesMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: "https://www.edamam.com/web-img/891/8913165cf2fbd4cd955cd23442dd2184.jpg", ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/")
        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name! == "Waldorf Salad")
    }
    
    func testDeleteAllIngredientsMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: "https://www.edamam.com/web-img/891/8913165cf2fbd4cd955cd23442dd2184.jpg", ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/")
        coreDataManager.deleteAllFavorites()
        XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
    }
}
