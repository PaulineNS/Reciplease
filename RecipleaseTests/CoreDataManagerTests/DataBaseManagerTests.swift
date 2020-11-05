//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Pauline Nomballais on 19/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//
@testable import Reciplease
import XCTest

final class DataBaseManagerTests: XCTestCase {
    
    // MARK: - Variables
    
    var dataBaseStack: MockDataBaseStack!
    var dataBaseManager: DataBaseEngine!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        dataBaseStack = MockDataBaseStack()
        dataBaseManager = DataBaseEngine(dataBaseStack: dataBaseStack)
    }
    
    override func tearDown() {
        super.tearDown()
        dataBaseManager = nil
        dataBaseStack = nil
    }
    
    // MARK: - Tests
    
    func testAddRecipeToFavoritesMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        dataBaseManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        XCTAssertTrue(!dataBaseManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(dataBaseManager.favoritesRecipes.count == 1)
        XCTAssertTrue(dataBaseManager.favoritesRecipes[0].name! == "Waldorf Salad")
    }
    
    func testDeleteAllRecipesMethod_WhenEntitiesAreDeleted_ThenShouldBeCorrectlyDeleted() {
        dataBaseManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        dataBaseManager.deleteAllFavorites()
        XCTAssertTrue(dataBaseManager.favoritesRecipes.isEmpty)
    }
    
    func testDeleteOneRecipeMethod_WhenEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
        dataBaseManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        dataBaseManager.addRecipeToFavorites(name: "Steak & Chips Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        dataBaseManager.deleteRecipeFromFavorite(recipeName: "Waldorf Salad")
        XCTAssertTrue(!dataBaseManager.favoritesRecipes.isEmpty)
        XCTAssertTrue(dataBaseManager.favoritesRecipes.count == 1)
        XCTAssertTrue(dataBaseManager.favoritesRecipes[0].name! == "Steak & Chips Salad")
    }
    
    func testCheckingIfRecipeIsAlreadyFavorite_WhenFuncIsCalling_ThenShouldReturnTrue() {
        dataBaseManager.addRecipeToFavorites(name: "Waldorf Salad", image: Data(), ingredientsDescription: "", recipeUrl: "http://www.bbcgoodfood.com/recipes/9753/", time: "")
        XCTAssertTrue(dataBaseManager.checkIfRecipeIsInFavorite(recipeName: "Waldorf Salad"))
    }
}
