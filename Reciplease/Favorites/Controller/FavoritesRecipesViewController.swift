//
//  FavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 26/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class FavoritesRecipesViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?
    var favoritesRecipesArray = [String]()

    @IBOutlet weak var favoritesRecipesTableView: UITableView! { didSet { favoritesRecipesTableView.tableFooterView = UIView() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        guard let urlImage = URL(string: recipeData[0].hits[indexPath.row].recipe.image) else {return UITableViewCell()}
//        
//        cell.configure(title: recipeData[0].hits[indexPath.row].recipe.label, pictureUrl: urlImage)
        
        return cell
    }
    
}

extension FavoritesRecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You have not added any reciped yet in your favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesRecipesArray.isEmpty ? 200 : 0
        //return coreDataManager?.tasks.isEmpty ?? true ? 200 : 0
    }
}
