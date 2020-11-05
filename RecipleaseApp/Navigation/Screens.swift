//
//  Screens.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

// MARK: - Child

enum recipeType {
    case foundRecipes
    case favoriteRecipes
}

final class Screens {

    // MARK: - Public Properties

    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
    
    // MARK: - Private Properties

    private let context: Context
    
    // MARK: - Initializer

    init(context: Context) {
        self.context = context
    }
}

protocol SearchViewModelDelegate: class {
    func homeScreenShouldDisplayAlert(for type: AlertType)
    func homeScreenDidSearchRecipe(recipes: [RecipeItem])
}

protocol RecipesViewModelDelegate: class {
    func recipeScreenShouldDisplayAlert(for type: AlertType)
    func recipeScreenDidTapRecipe(recipe: RecipeItem)
}

protocol RecipeDetailsViewModelDelegate: class {
    func detailsScreenDidSelectDeleteButton()
}

// MARK : - Main

extension Screens {
    
    func createSearchViewController(delegate: SearchViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let repository = SearchRepository(networkClient: context.client,
                                          dataBaseEngine: context.dataBaseEngine)
        let viewModel = SearchViewModel(repository: repository,
                                        delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createRecipesViewController(delegate: RecipesViewModelDelegate?,
                                     recipes: [RecipeItem]? = nil,
                                     tableViewtype: recipeType) -> RecipesViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
        let repository = RecipesRepository(dataBaseEngine: context.dataBaseEngine)
        switch tableViewtype {
        case .foundRecipes:
            let viewModel = RecipesViewModel(recipeItems: recipes ?? [],
                                             repository: repository,
                                             delegate: delegate)
            viewController.viewModel = viewModel
        case .favoriteRecipes:
            let viewModel = RecipesViewModel(recipeItems: nil,
                                             repository: repository,
                                             delegate: delegate)
            viewController.viewModel = viewModel
        }
        return viewController
    }
}

extension Screens {
    
    func createRecipeDetailsViewController(recipe: RecipeItem,
                                           delegate: RecipeDetailsViewModelDelegate?) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        let repository = RecipeDetailsRepository(dataBaseEngine: context.dataBaseEngine)
        let viewModel = RecipeDetailsViewModel(recipeItem: recipe,
                                               repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Simple Alert

extension Screens {

    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(action)
        return alertController
    }

}

