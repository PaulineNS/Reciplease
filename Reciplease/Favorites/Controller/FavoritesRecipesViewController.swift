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
    var favoritesRecipesArray = [String]()
    
    @IBOutlet weak var favoritesRecipesTableView: UITableView! { didSet { favoritesRecipesTableView.tableFooterView = UIView() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (coreDataManager?.favoritesRecipes.count as Any)
        favoritesRecipesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print (coreDataManager?.favoritesRecipes.count as Any)
        favoritesRecipesTableView.reloadData()
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
