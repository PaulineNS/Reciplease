//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeIngredientsTxtView: UITextView!
    @IBOutlet private weak var favoritesIconButton: UIBarButtonItem!
    
    // MARK: - Public Properties

    var viewModel: RecipeDetailsViewModel!
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeIngredientsTxtView.isEditable = false
        updateTheNavigationBar(navBarItem: navigationItem)
        bind(to: viewModel)
        viewModel.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.updateTheFavoriteIcon()
    }

    // Show the textView At the top
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeIngredientsTxtView.contentOffset = .zero
    }
    
    // MARK: - Bindings

    private func bind(to viewModel: RecipeDetailsViewModel) {
        viewModel.favoriteIconImageName = { [weak self] name in
            self?.favoritesIconButton.image = UIImage(named: name)
        }
        viewModel.recipeName = { [weak self] name in
            self?.recipeTitleLabel.text = name
        }
        viewModel.recipeImage = { [weak self] image in
            self?.recipeImageView.image = UIImage(data: image)
        }
        viewModel.recipeIngredients = { [weak self] ingredients in
            self?.recipeIngredientsTxtView.text = ingredients
        }
    }
}

// MARK: - Actions

extension RecipeDetailsViewController {
    
    /// Action after typing the Get Directions Button
    @IBAction private func didTapGetDirectionsButton(_ sender: Any) {
        viewModel.selectGetDirectionsButton { url in
            UIApplication.shared.open(url)
        }
    }
    
    /// Action after typing the favorite icon
    @IBAction private func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "heart") {
            sender.image = UIImage(named: "fullHeart")
            viewModel.addRecipeToFavorites()
        } else if sender.image == UIImage(named: "fullHeart") {
            sender.image = UIImage(named: "heart")
            viewModel.deleteRecipeFromFavorites()
        }
    }
}
