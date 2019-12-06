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
    
    // MARK: - Variables
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
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
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name! == "Waldorf Salad")
    }
    
    func testDeleteAllRecipesMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        coreDataManager.deleteAllFavorites()
        XCTAssertTrue(coreDataManager.favoritesRecipes.isEmpty)
    }
    
    func testDeleteOneRecipeMethod_WhenEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        coreDataManager.addRecipeToFavorites(name: "Steak & Chips Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        coreDataManager.deleteRecipeFromFavorite(recipeName: "Waldorf Salad")
        XCTAssertTrue(!coreDataManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipes.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipes[0].name! == "Steak & Chips Salad")
    }
    
    func testCheckingIfRecipeIsAlreadyFavorite_WhenFuncIsCalling_ThenShouldReturnTrue() {
        coreDataManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        XCTAssertTrue(coreDataManager.checkIfRecipeIsAlreadyFavorite(recipeName: "Waldorf Salad"))
    }
}
