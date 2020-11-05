//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Private properties

    private let route = Route()
    private let repository: SearchRepositoryType
    private weak var delegate: SearchViewModelDelegate?
    private var ingredientsSearched: [String] = [] {
        didSet {
            ingredientsToSearch?(ingredientsSearched)
        }
    }
    
    // MARK: - Initializer
    
    init(repository: SearchRepositoryType,
         delegate: SearchViewModelDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: - Outputs

    var ingredientsToSearch: (([String]) -> Void)?
    var searchPlaceholder: ((String) -> Void)?
    
    // MARK: - Life cycle

    func start() {
        searchPlaceholder?("I'm looking for an ingredient...")
    }
    
    // MARK: - Inputs

    func didSelectClearButton() {
        ingredientsSearched = []
    }
    
    func didSelectGoButton(for vegetarian: Bool,
                           completion: @escaping (Bool) -> Void) {
        guard ingredientsSearched.count != 0 else {
            delegate?.homeScreenShouldDisplayAlert(for: .noIngredients)
            completion(true)
            return
        }
        guard let allIngredients = ingredientsSearched
                .joined(separator: ",")
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard vegetarian else {
            getRecipes(ingredients: allIngredients,
                       health: "",
                       completion: completion)
            return
        }
        getRecipes(ingredients: allIngredients,
                   health: "&health=vegetarian",
                   completion: completion)
    }
    
    func didAdd(ingredient: String) {
        guard !ingredient.isBlank else {
            delegate?.homeScreenShouldDisplayAlert(for: .noIngredients)
            return}
        searchPlaceholder?("I'm looking for an ingredient...")
        ingredientsSearched.append(ingredient)
    }
    
    // MARK: - Private Methods

    private func getRecipes(ingredients: String,
                            health: String,
                            completion: @escaping (Bool) -> Void) {
        guard let url = route.getURL(ingredients: ingredients,
                                     health: health) else { return }
        repository.getRecipes(url: url,
                              callback: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipeItems):
                    guard recipeItems.count != 0 else {
                        self?.delegate?.homeScreenShouldDisplayAlert(for: .noRecipesFound)
                        completion(true)
                        return
                    }
                    self?.delegate?.homeScreenDidSearchRecipe(recipes: recipeItems)
                    completion(true)
                case .error:
                    self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
                    completion(true)
                }
            }
        }, error: { [weak self] alert in
            self?.delegate?.homeScreenShouldDisplayAlert(for: .networkError)
            completion(true)
            return
        })
    }
}
