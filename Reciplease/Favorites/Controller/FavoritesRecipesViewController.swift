//
//  FavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class FavoritesRecipesViewController: UIViewController {
    
    var searchDetailsService = SearchDetailsService()    
    var coreDataManager: CoreDataManager?
    var favoritesRecipeDetailArray:FavoritesRecipesList?
    
    
    @IBOutlet weak var favoritesRecipesTableView: UITableView! { didSet { favoritesRecipesTableView.tableFooterView = UIView() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromFavoritesRecipesToDetailsVC" else {
            return
        }
        guard let recipesVc = segue.destination as? RecipeDetailsViewController else {return}
        recipesVc.favoriteRecipeDetailsData = favoritesRecipeDetailArray
        recipesVc.isSegueFromFavoriteVc = true
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        coreDataManager?.deleteAllFavorites()
    }
}

extension FavoritesRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoritesRecipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let urlImage = URL(string: coreDataManager?.favoritesRecipes[indexPath.row].image ?? "") else { return UITableViewCell()}
        
        cell.configure(title: coreDataManager?.favoritesRecipes[indexPath.row].name ?? "", pictureUrl: urlImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesRecipeDetailArray = coreDataManager?.favoritesRecipes[indexPath.row]
        self.performSegue(withIdentifier: "fromFavoritesRecipesToDetailsVC", sender: nil)
    }
}

extension FavoritesRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You have not added any recipes yet in your favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoritesRecipes.isEmpty ?? true ? 200 : 0
    }
}
