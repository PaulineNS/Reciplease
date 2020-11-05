//
//  FavoriteCoordinator.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class FavoriteCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private var recipeViewController: RecipesViewController?

    
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Coodinator
    
    func start() {
        showFavoriteRecipes()
    }
    
    // MARK: - Favorite Recipes

    private func showFavoriteRecipes() {
        recipeViewController = screens.createRecipesViewController(delegate: self,
                                                                 tableViewtype: .favoriteRecipes)
        presenter.viewControllers = [(recipeViewController ?? RecipesViewController()) as UIViewController]
    }
    
    // MARK: - Details Recipe

    private func showRecipeDetail(recipe: RecipeItem) {
        let viewController = screens.createRecipeDetailsViewController(recipe: recipe, delegate: self)
        presenter.pushViewController(viewController, animated: true)
    }
    
    // MARK: - SimpleAlert

    private func showSimpleAlert(for type: AlertType) {
        let alert = screens.createAlert(for: type)
        presenter.visibleViewController?.present(alert,
                                                 animated: true,
                                                 completion: nil)
    }
}

extension FavoriteCoordinator: RecipesViewModelDelegate {
    func recipeScreenShouldDisplayAlert(for type: AlertType) {
        showSimpleAlert(for: type)
    }
    
    func recipeScreenDidTapRecipe(recipe: RecipeItem) {
        showRecipeDetail(recipe: recipe)
    }
}

extension FavoriteCoordinator: RecipeDetailsViewModelDelegate {
    
    func detailsScreenDidSelectDeleteButton() {
        recipeViewController?.didRemoveARecipeFromFavorites()
        presenter.popViewController(animated: true)
    }
}
