//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Variables

    var recipeRepresentable: RecipeClassRepresentable?
    private var coreDataManager: CoreDataManager?
    
    // MARK: - Outlets

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeIngredientsTxtView: UITextView!
    @IBOutlet private weak var favoritesIconButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeIngredientsTxtView.isEditable = false
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updateTheNavigationBar(navBarItem: navigationItem)
        updateTheView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeIngredientsTxtView.contentOffset = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateTheFavoriteIcon()
    }
}

// MARK: - Properties

extension RecipeDetailsViewController {
    
    /// Update the favorite icon
    private func updateTheFavoriteIcon(){
        guard coreDataManager?.checkIfRecipeIsAlreadyFavorite(recipeName: recipeTitleLabel.text ?? "") == true else {
            favoritesIconButton.image = UIImage(named: "heart")
            return }
        favoritesIconButton.image = UIImage(named: "fullHeart")
    }
    
    /// Update the View
    private func updateTheView() {
        recipeTitleLabel.text = recipeRepresentable?.label
        recipeImageView.image = UIImage(data: recipeRepresentable?.image ?? Data())
        recipeIngredientsTxtView.text = recipeRepresentable?.ingredientLines
    }
}

// MARK: - CoreData Properties

extension RecipeDetailsViewController {
    
    /// Delete recipe from coredata depending his name
    private func deleteRecipeFromFavorites(){
        coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeTitleLabel.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    /// Adding recipes to coredata
    private func addRecipeToFavorites() {
        guard let name = recipeRepresentable?.label, let image = recipeRepresentable?.image, let ingredients = recipeRepresentable?.ingredientLines, let url = recipeRepresentable?.url, let time = recipeRepresentable?.totalTime else {return}
        coreDataManager?.addRecipeToFavorites(name: name, image: image, ingredientsDescription: ingredients, recipeUrl: url, time: time)
    }
}

// MARK: - Actions

extension RecipeDetailsViewController {
    
    /// Action after typing the Get Directions Button
    @IBAction private func didTapGetDirectionsButton(_ sender: Any) {
        guard let directionsUrl = URL(string: recipeRepresentable?.url ?? "") else {return}
        UIApplication.shared.open(directionsUrl)
    }
    
    /// Action after typing the favorite icon
    @IBAction private func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "heart") {
            sender.image = UIImage(named: "fullHeart")
            addRecipeToFavorites()
        } else if sender.image == UIImage(named: "fullHeart") {
            sender.image = UIImage(named: "heart")
            deleteRecipeFromFavorites()
        }
    }
}
