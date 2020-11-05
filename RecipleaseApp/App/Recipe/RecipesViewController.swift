//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var recipesTableView: UITableView! {
        didSet {
            recipesTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Public Properties

    var viewModel: RecipesViewModel!
    
    // MARK: - Private Properties

    private lazy var source: RecipesDataSource = RecipesDataSource()
    
    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesTableView.delegate = source
        recipesTableView.dataSource = source
        viewModel.start()
        recipesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: source)
        bind(to: viewModel)
//        viewModel.start()
        recipesTableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell",
                            bundle: nil)
        recipesTableView.register(nibName,
                                  forCellReuseIdentifier: "recipeCell")
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    // MARK: - Bindings

    private func bind(to source: RecipesDataSource) {
        source.selectedRecipe = viewModel.didSelectRecipe
    }
    
    private func bind(to viewModel: RecipesViewModel) {
        viewModel.recipes = { [weak self] recipes in
            self?.source.updateCell(with: recipes)
            self?.recipesTableView.reloadData()
        }
    }
    
    func didRemoveARecipeFromFavorites() {
        viewModel.getFavoritesRecipes()
    }
}
