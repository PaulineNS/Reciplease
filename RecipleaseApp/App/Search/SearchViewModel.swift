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
    var activityIndicatorIsHidden: ((Bool) -> Void)?
    var rightBarButtonItemIsHidden: ((Bool) -> Void)?
    
    // MARK: - Life cycle

    func start() {
        rightBarButtonItemIsHidden?(true)
    }
    
    func updateView() {
        searchPlaceholder?("I'm looking for an ingredient...")
        activityIndicatorIsHidden?(true)
    }
    
    // MARK: - Inputs

    func didSelectClearButton() {
        rightBarButtonItemIsHidden?(true)
        ingredientsSearched = []
    }
    
    func didSelectGoButton(for vegetarian: Bool) {
        guard ingredientsSearched.count != 0 else {
            delegate?.homeScreenShouldDisplayAlert(for: .noIngredients)
            return
        }
        guard let allIngredients = ingredientsSearched
                .joined(separator: ",")
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        activityIndicatorIsHidden?(false)
        let health = vegetarian ? "&health=vegetarian" : ""
        getRecipes(ingredients: allIngredients,
                   health: health) { [weak self] response in
            if response == true {
                self?.activityIndicatorIsHidden?(true)
            }
        }
    }
    
    func didAdd(ingredient: String) {
        guard !ingredient.isBlank else {
            delegate?.homeScreenShouldDisplayAlert(for: .noIngredients)
            return}
        searchPlaceholder?("I'm looking for an ingredient...")
        ingredientsSearched.append(ingredient)
        rightBarButtonItemIsHidden?(false)

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
