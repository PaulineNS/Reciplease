//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var recipeService = SearchService()
    var ingredientsArray = [String]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeService.getRecipes(ingredients: "chicken") { result in
            switch result {
            case .success(let data):
                print("\(data.hits[0].recipe.calories)")
            case .failure:
                print("oups")
            }
        }
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    @IBAction func didTapButtonToAddIngredient(_ sender: Any) {
        guard searchTextField.text?.isEmpty == false else {
            presentAlert(message: "Please enter an ingredient :) ")
            return
        }
        addIngredientToTableView()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func didTapGoButton(_ sender: Any) {
        performSegue(withIdentifier: "fromSearchToRecipesVC", sender: nil)
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesVc = segue.destination as? RecipesViewController else {return}
        recipesVc.ingredients = ingredientsArray
    }
    
    func addIngredientToTableView() {
        guard let searchbarTxt = searchTextField.text else {
            return
        }
        ingredientsArray.append(searchbarTxt)
        searchTextField.text = " "
        print("\(ingredientsArray)")
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

