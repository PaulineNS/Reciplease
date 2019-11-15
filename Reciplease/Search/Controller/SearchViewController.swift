//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/10/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?
    var searchService = SearchService()
    var ingredientsArray = [String]()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        searchService.getRecipes(ingredients: "chicken") { result in
            switch result {
            case .success(let data):
                print("\(data.hits[0].recipe.calories)")
            case .failure:
                print("oups")
            }
        }
        setUpNavBar()
    }
    
    func setUpNavBar() {
        
        if let navigationController = navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            let image = #imageLiteral(resourceName: "chief")
            let imageView = UIImageView(image: image)
            
            let bannerWidth = navigationController.navigationBar.frame.size.width
            let bannerHeight = navigationController.navigationBar.frame.size.height
            
            let bannerX = bannerWidth / 2 - image.size.width / 2
            let bannerY = bannerHeight / 2 - image.size.width / 2
            
            imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
            imageView.contentMode = .scaleAspectFit
            
            navigationItem.titleView = imageView
        }
    }
    
    @IBAction func didTapButtonToAddIngredient(_ sender: Any) {
        guard let ingredientName = searchTextField.text, !ingredientName.isBlank else {
            presentAlert(message: "Veuillez saisir un ingrédient")
            return}
        coreDataManager?.createIngredient(name: ingredientName)
        searchTextField.text = " "
        ingredientsTableView.reloadData()
    }
    
    @IBAction func didTapGoButton(_ sender: Any) {
        //fillIngredientArray()
        searchService.getRecipes(ingredients: "chicken" /*ingredientsArray.joined(separator: ",")*/) { result in
            switch result {
            case .success(let data):
                print("\(data.hits[0].recipe.calories)")
                self.performSegue(withIdentifier: "fromSearchToRecipesVC", sender: nil)
            case .failure:
                self.presentAlert(message: "Veuillez rééssayer ulterieurement")
            }
        }
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        coreDataManager?.deleteAllIngredients()
        ingredientsTableView.reloadData()
    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let recipesVc = segue.destination as? RecipesViewController else {return}
//        recipesVc.recipesTableView.reloadData()
//    }
//
    
    func fillIngredientArray() {
        ingredientsArray = [String]()
        guard let numberOfIngredients = coreDataManager?.ingredients.count else {return}
        for index in 0...numberOfIngredients - 1 {
            ingredientsArray.append(coreDataManager?.ingredients[index].name ?? "")
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        cell.textLabel?.text = coreDataManager?.ingredients[indexPath.row].name
        
        return cell
    }
}

