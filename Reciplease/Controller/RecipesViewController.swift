//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    /// MARK: - Variables
    private var recipeRepresentable: RecipeClassRepresentable?
    var recipeData: Recipe?
    
    /// MARK: - Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    /// MARK: - Segue to RecipeDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromAllRecipesToDetailsVC" else {
            return
        }
        guard let recipesVc = segue.destination as? RecipeDetailsViewController else {return}
        recipesVc.recipeRepresentable = recipeRepresentable
    }
}

/// MARK: - Creating The TableView
extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData?.hits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = recipeData?.hits?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipeData?.hits?[indexPath.row]
        guard let imageUrl = recipe?.recipe?.image, let ingredientsArray = recipe?.recipe?.ingredientLines else {return}
        let recipeRepresentable = RecipeClassRepresentable(label: recipe?.recipe?.label, image: obtainImageDataFromUrl(stringImageUrl: imageUrl), url: recipe?.recipe?.url, ingredientLines: "-" + " " + ingredientsArray.joined(separator: "\n\n" + "-" + " ") , totalTime: recipe?.recipe?.totalTime?.convertIntToTime)
        self.recipeRepresentable = recipeRepresentable
        performSegue(withIdentifier:"fromAllRecipesToDetailsVC", sender: nil)
    }
}

