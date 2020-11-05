//
//  RecipesViewModel.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

final class RecipesViewModel {
    
    // MARK: - Private properties
    
    private var recipeItems: [RecipeItem]?
    private let repository: RecipesRepositoryType
    private weak var delegate: RecipesViewModelDelegate?
    
    // MARK: - Initializer
    
    init(recipeItems: [RecipeItem]?,
         repository: RecipesRepositoryType,
         delegate: RecipesViewModelDelegate?) {
        self.recipeItems = recipeItems
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs

    var recipes: (([RecipeItem]) -> Void)?
    
    // MARK: - Input

    func start() {
        if recipeItems == nil {
            repository.getRecipes { [weak self] result in
                switch result {
                case.success(value: let recipes):
                    self?.recipeItems = recipes
                case .error(error: let error):
                    print(error)
                    //TODO ERROR
                }
            }
        }
        recipes?(recipeItems ?? [])
    }
    
    func didSelectRecipe(recipe: RecipeItem) {
        delegate?.recipeScreenDidTapRecipe(recipe: recipe)
    }
    
    func getFavoritesRecipes() {
        recipeItems = nil
    }

}

