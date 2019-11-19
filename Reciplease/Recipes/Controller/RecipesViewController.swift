//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    var searchService = SearchService()
    
    var recipeTitle = ""
    var recipeImage = UIImageView()
    var recipeData = [Recipe]()

    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.reloadData()
        print(recipeData)
        print (recipeData[0].hits.count)
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData[0].hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        guard let urlImage = URL(string: recipeData[0].hits[indexPath.row].recipe.image) else {return UITableViewCell()}
        
        cell.configure(title: recipeData[0].hits[indexPath.row].recipe.label, pictureUrl: urlImage)
        
        return cell
    }
}
