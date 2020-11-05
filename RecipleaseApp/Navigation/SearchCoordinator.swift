//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class SearchCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    
    private let screens: Screens
        
    // MARK: - Initializer
    
    init(presenter: UINavigationController,
         screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coodinator
    
    func start() {
        showHome()
    }
    
    // MARK: - Home

    private func showHome() {
        let viewController = screens.createSearchViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    // MARK: - Recipes List

    private func showRecipes(recipes: [RecipeItem]) {
        let viewController = screens.createRecipesViewController(delegate: self,
                                                                 recipes: recipes,
                                                                 tableViewtype: .foundRecipes)
        presenter.pushViewController(viewController,
                                     animated: true)
    }
    
    // MARK: - Details Recipe

    private func showRecipeDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipeDetailsViewController(recipe: recipe, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }

    
    // MARK: - SimpleAlert

    private func showSimpleAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert, animated: true,
                                                 completion: nil)
    }
}

extension SearchCoordinator: SearchViewModelDelegate {
    
    func homeScreenDidSearchRecipe(recipes: [RecipeItem]) {
        showRecipes(recipes: recipes)
    }
    
    func homeScreenShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }
    
}

extension SearchCoordinator: RecipesViewModelDelegate {
    func recipeScreenShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }
    
    func recipeScreenDidTapRecipe(recipe: RecipeItem) {
        showRecipeDetail(recipe: recipe)
    }
}

extension SearchCoordinator: RecipeDetailsViewModelDelegate {
    
    func detailsScreenDidSelectDeleteButton() {}
    
}
