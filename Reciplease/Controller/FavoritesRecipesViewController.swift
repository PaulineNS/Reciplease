//
//  FavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class FavoritesRecipesViewController: UIViewController {
    
    /// MARK: - Variables
    private var recipeRepresentable: RecipeClassRepresentable?
    private var coreDataManager: CoreDataManager?
    
    /// MARK: - Outlets
    @IBOutlet weak var favoritesRecipesTableView: UITableView! { didSet { favoritesRecipesTableView.tableFooterView = UIView() }}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoritesRecipesTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        favoritesRecipesTableView.reloadData()
    }
    
    /// MARK: - Segue to RecipeDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromFavoritesRecipesToDetailsVC" else {return}
        guard let recipesVc = segue.destination as? RecipeDetailsViewController else {return}
        recipesVc.recipeRepresentable = recipeRepresentable
    }
    
    /// MARK: - Action 
    @IBAction func didTapClearButton(_ sender: Any) {
        coreDataManager?.deleteAllFavorites()
        favoritesRecipesTableView.reloadData()
    }
}

/// Creating The TableView
extension FavoritesRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoritesRecipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.favoriteRecipe = coreDataManager?.favoritesRecipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoritesRecipes[indexPath.row]
        let recipeRepresentable = RecipeClassRepresentable(label: favoriteRecipe?.name, image: favoriteRecipe?.image, url: favoriteRecipe?.recipeUrl, ingredientLines: favoriteRecipe?.ingredients, totalTime: favoriteRecipe?.totalTime)
        self.recipeRepresentable = recipeRepresentable
        self.performSegue(withIdentifier: "fromFavoritesRecipesToDetailsVC", sender: nil)
    }
}

extension FavoritesRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You haven't any favorites yet"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoritesRecipes.isEmpty ?? true ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let recipeName = coreDataManager?.favoritesRecipes[indexPath.row].name else {return}
        coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeName)
        favoritesRecipesTableView.reloadData()
    }
}
