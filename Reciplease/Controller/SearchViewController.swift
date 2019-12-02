//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    /// MARK: - Instantiation
    var searchService = SearchRecipesService()
    
    /// MARK: - Var
    var ingredientsArray = [String]()
    var recipeDataReceived: Recipe?
    
    /// MARK: - Outlets
    @IBOutlet weak var vegetarianSwitch: UISwitch!
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView! { didSet { ingredientsTableView.tableFooterView = UIView() }}
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivityIndicator.isHidden = true
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    /// MARK: - Segue to RecipeViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromSearchToRecipesVC" else {return}
        guard let recipesVc = segue.destination as? RecipesViewController else {return}
        recipesVc.recipeData = recipeDataReceived
    }
    
    /// MARK: - Request Service
    private func getRecipesDependingVegetarianSwitch(_ allIngredients: String, _ health: String) {
        loadActivityIndicator.isHidden = false
        searchRecipesButton.isHidden = true
        searchService.getRecipes(ingredients: allIngredients, health: health) { result in
            self.loadActivityIndicator.isHidden = true
            self.searchRecipesButton.isHidden = false
            switch result {
            case .success(let data):
                if data.count != 0 {
                    self.recipeDataReceived = data
                    self.performSegue(withIdentifier: "fromSearchToRecipesVC", sender: nil)
                } else {
                    self.presentAlert(message: "No recipes found")
                }
            case .failure:
                self.presentAlert(message: "Please try later")
            }
        }
    }
    
    private func addIngredientToTableView() {
        guard let searchBarTxt = searchTextField.text else {return}
        ingredientsArray.append(searchBarTxt)
        searchTextField.text = " "
    }
}

/// MARK: - IBActions
extension SearchViewController {
    @IBAction func didTapButtonToAddIngredient(_ sender: Any) {
        guard let ingredientName = searchTextField.text, !ingredientName.isBlank else {
            presentAlert(message: "Veuillez saisir un ingrédient")
            return}
        addIngredientToTableView()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func didTapGoButton(_ sender: Any) {
        guard ingredientsArray.count != 0 else {
            presentAlert(message: "You have to enter at least 1 ingredient")
            return
        }
        guard let allIngredients = ingredientsArray.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard vegetarianSwitch.isOn else {
            getRecipesDependingVegetarianSwitch(allIngredients, "")
            return
        }
        getRecipesDependingVegetarianSwitch(allIngredients, "&health=vegetarian")
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        ingredientsArray = [String]()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}

/// MARK: - Creating The TableView
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = ingredientsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsArray.remove(at: indexPath.row)
            ingredientsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .center
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredientsArray.isEmpty ? 400 : 0
    }
}

