//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    var recipeService = SearchService()
    
    var ingredients = [String]()
    

    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeService.getRecipes(ingredients: "chicken") { result in
            switch result {
            case .success(let data):
                print("\(data.hits[0].recipe.calories)")
            case .failure():
                print("oups")
            }
        }
        // print ("\(ingredients.joined(separator: ","))")
    }
}

extension RecipesViewController {
    func displayAllRecipes() {
        recipeService.getRecipes(ingredients: ingredients.joined(separator: ",")) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.recipesTableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.presentAlert(message: "Problème au moment du chargement des recettes.")
                }
            }
        }
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeService.recipeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
