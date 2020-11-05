//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

final class RecipeDetailsViewModel {
    
    // MARK: - Private properties
    
    private var recipeItem: RecipeItem
    private let repository: RecipeDetailsRepositoryType
    private weak var delegate: RecipeDetailsViewModelDelegate?
    
    // MARK: - Initializer
    
    init(recipeItem: RecipeItem,
         repository: RecipeDetailsRepositoryType,
         delegate: RecipeDetailsViewModelDelegate?) {
        self.recipeItem = recipeItem
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs

    var recipe: ((RecipeItem) -> Void)?
    var favoriteIconImageName: ((String) -> Void)?
    var recipeName: ((String) -> Void)?
    var recipeImage: ((Data) -> Void)?
    var recipeIngredients: ((String) -> Void)?
    
    // MARK: - Input

    func start() {
        recipe?(recipeItem)
        recipeName?(recipeItem.name)
        recipeImage?(recipeItem.image )
        recipeIngredients?(recipeItem.ingredients)
    }
    
    func selectGetDirectionsButton(completion: @escaping (URL) -> Void) {
        guard let directionsUrl = URL(string: recipeItem.url) else { return }
        completion(directionsUrl)
    }
    
    /// Delete recipe from coredata depending his name
    func deleteRecipeFromFavorites(){
        repository.deleteRecipeFromFavorites(recipeName: recipeItem.name)
        delegate?.detailsScreenDidSelectDeleteButton()
    }
    
    /// Adding recipes to coredata
    func addRecipeToFavorites() {
        repository.addRecipeToFavorites(recipeItem: recipeItem)
    }
        
    func updateTheFavoriteIcon(){
        guard repository.checkIfRecipeIsInFavorite(recipeName: recipeItem.name) == true else {
            favoriteIconImageName?("heart")
            return }
        favoriteIconImageName?("fullHeart")
    }
}
