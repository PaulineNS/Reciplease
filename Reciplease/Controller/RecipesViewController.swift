//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    // Variables
    var recipeData: Recipe?
    var recipeDetailsDataReceived: Hit?
    
    // Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromAllRecipesToDetailsVC" else {
            return
        }
        guard let recipesVc = segue.destination as? RecipeDetailsViewController else {return}
        recipesVc.recipeDetailsData = recipeDetailsDataReceived
        recipesVc.isSegueFromFavoriteVc = false
    }
    
    func updateRecipeData(indexPath: IndexPath){
        recipeDetailsDataReceived = recipeData?.hits?[indexPath.row]
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
//        guard let urlImage = URL(string: recipeData[0].hits[indexPath.row].recipe.image) else { return UITableViewCell()
//        }
        cell.recipe = recipeData?.hits?[indexPath.row]
//        cell.configure(title: recipeData[0].hits[indexPath.row].recipe.label, pictureUrl: urlImage, time: recipeData[0].hits[indexPath.row].recipe.totalTime.convertIntToTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateRecipeData(indexPath: indexPath)
        performSegue(withIdentifier:"fromAllRecipesToDetailsVC", sender: nil)
    }
}

