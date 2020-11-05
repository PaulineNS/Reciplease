//
//  RecipesDataSource.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 04/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipesDataSource: NSObject {

    // MARK: - Public properties

    private var recipes = [RecipeItem]()
    var selectedRecipe: ((RecipeItem) -> Void)?

    // MARK: - Methods

    func updateCell (with recipes: [RecipeItem]) {
        self.recipes = recipes
    }

}

extension RecipesDataSource: UITableViewDelegate,
                            UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell",
                                                       for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < recipes.count else { return }
        selectedRecipe?(recipes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let translation = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = translation
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    /// Display the tableView footer depending the number of elements in favoritesRecipes
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return recipes.isEmpty ? tableView.bounds.size.height : 0
    }
    
    /// Get in shape the tableView footer
    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You haven't any favorites yet 😢 "
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.08918375522, green: 0.2295971513, blue: 0.2011210024, alpha: 1)
        return label
    }
    
}
