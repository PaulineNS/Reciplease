//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchService = SearchService()
    var ingredientsArray = [String]()
    var recipeDataReceived = [Recipe]()

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapButtonToAddIngredient(_ sender: Any) {
        guard let ingredientName = searchTextField.text, !ingredientName.isBlank else {
            presentAlert(message: "Veuillez saisir un ingrédient")
            return}
        addIngredientToTableView()
        ingredientsTableView.reloadData()
    }
    
    func addIngredientToTableView() {
        guard let searchBarTxt = searchTextField.text else {return}
        ingredientsArray.append(searchBarTxt)
        searchTextField.text = " "
    }
    
    @IBAction func didTapGoButton(_ sender: Any) {
        guard ingredientsArray.count != 0
            else {
            presentAlert(message: "You have to enter at least 1 ingredient")
            return
        }
        guard let allIngredients = ingredientsArray.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        searchService.getRecipes(ingredients: allIngredients) { result in
            switch result {
            case .success(let data):
                self.recipeDataReceived = [data]
                self.performSegue(withIdentifier: "fromSearchToRecipesVC", sender: nil)
            case .failure:
                self.presentAlert(message: "Veuillez rééssayer ulterieurement")
            }
        }
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        ingredientsArray = [String]()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromSearchToRecipesVC" else {return}
        guard let recipesVc = segue.destination as? RecipesViewController else {return}
        recipesVc.recipeData = recipeDataReceived
    }
}

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
}

