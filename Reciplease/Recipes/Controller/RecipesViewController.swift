//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    var searchDetailsService = SearchDetailsService()

    var recipeData = [Recipe]()
    var recipeDetailsDataReceived = [[RecipeDetail]()]
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipesTableView.register(nibName, forCellReuseIdentifier: "recipeCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateTheNavigationBar(navBarItem: navigationItem)
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData[0].hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        guard let urlImage = URL(string: recipeData[0].hits[indexPath.row].recipe.image) else { return UITableViewCell()
        }
        cell.configure(title: recipeData[0].hits[indexPath.row].recipe.label, pictureUrl: urlImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchDetailsService.getRecipeDetails(recipeId: recipeData[0].hits[indexPath.row].recipe.uri) { result in
            switch result {
            case .success(let data):
                self.recipeDetailsDataReceived = [data]
                self.performSegue(withIdentifier: "fromAllRecipesToDetailsVC", sender: nil)
            case .failure:
                self.presentAlert(message: "Veuillez rééssayer ulterieurement")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromAllRecipesToDetailsVC" else {
            return
        }
        guard let recipesVc = segue.destination as? RecipeDetailsViewController else {return}
        recipesVc.recipeDetailsData = recipeDetailsDataReceived
        recipesVc.isSegueFromFavoriteVc = false
    }
}

