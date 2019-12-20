//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Instantiation
    
    private let searchService = SearchService()
    
    // MARK: - Variables
    
    private var ingredientsArray = [String]()
    private var recipeDataReceived: Recipe?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var vegetarianSwitch: UISwitch!
    @IBOutlet private weak var loadActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView! { didSet { ingredientsTableView.tableFooterView = UIView() }}
    @IBOutlet private weak var searchRecipesButton: UIButton!
    @IBOutlet private var clearButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivityIndicator.isHidden = true
        navigationItem.rightBarButtonItem = nil
    }
}

// MARK: - Actions

extension SearchViewController {
    @IBAction private func didTapAddButton(_ sender: Any) {
        guard let ingredientName = searchTextField.text, !ingredientName.isBlank else {
            presentAlert(message: "Please enter an ingredient 😃")
            return}
        addIngredientToTableView()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func didTapClearButton(_ sender: Any) {
        navigationItem.rightBarButtonItem = nil
        ingredientsArray = [String]()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func didTapGoButton(_ sender: Any) {
        guard ingredientsArray.count != 0 else {
            presentAlert(message: "You have to enter at least 1 ingredient 😃")
            return
        }
        guard let allIngredients = ingredientsArray.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard vegetarianSwitch.isOn else {
            getRecipes(allIngredients, "")
            return
        }
        getRecipes(allIngredients, "&health=vegetarian")
    }
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
}

// MARK: - Properties

extension SearchViewController {
    
    /// Add ingredient to the tableView
    private func addIngredientToTableView() {
        guard let searchBarTxt = searchTextField.text else {return}
        ingredientsArray.append(searchBarTxt)
        searchTextField.text = nil
        searchTextField.placeholder = "I'm looking for an ingredient..."
        navigationItem.rightBarButtonItem = clearButton
    }
    
    /// Request Service
    private func getRecipes(_ allIngredients: String, _ health: String) {
        loadActivityIndicator.isHidden = false
        searchRecipesButton.isHidden = true
        searchService.getRecipes(ingredients: allIngredients, health: health) { result in
            DispatchQueue.main.async {
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
    }
    
    /// Segue to RecipeViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromSearchToRecipesVC" else {return}
        guard let recipesVc = segue.destination as? RecipesViewController else {return}
        recipesVc.recipeData = recipeDataReceived
    }
}

// MARK: - TableView

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = "-" + " " + ingredientsArray[indexPath.row].capitalized
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = #colorLiteral(red: 0.08918375522, green: 0.2295971513, blue: 0.2011210024, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Savoye LET", size: 40)
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
        imageView.image = #imageLiteral(resourceName: "reciplease")
        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .center
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredientsArray.isEmpty ? tableView.bounds.size.height : 0
    }
}



