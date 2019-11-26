//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?
    var recipeDetailsData = [[RecipeDetail]()]
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTxtView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheView()
    }
    
    func updateTheView() {
        recipeTitleLabel.text = recipeDetailsData[0][0].label
        guard let urlImage = URL(string: recipeDetailsData[0][0].image) else {
            return
        }
        recipeImageView.load(url: urlImage)
        recipeIngredientsTxtView.text = "-" + " " +  recipeDetailsData[0][0].ingredientLines.joined(separator: "\n\n" + "-" + " " )
    }
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        guard let directionsUrl = URL(string: recipeDetailsData[0][0].url) else {return}
        UIApplication.shared.open(directionsUrl)
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        print("first")
        if sender.image == UIImage(named: "heart") {
            print("second")
            sender.image = UIImage(named: "fullHeart")
            guard let name = recipeDetailsData[0][0].label else {
                print("bienvenu")
                return}
            print("troisième")
            coreDataManager?.addRecipeToFavorites(name: name, image: recipeDetailsData[0][0].image, ingredients: "-" + " " + recipeDetailsData[0][0].ingredientLines.joined(separator: "\n\n" + "-" + " "))
            print(coreDataManager?.favoritesRecipes[0] as Any)
            print("nulnul")
        } else if sender.image == UIImage(named: "fullHeart") {
            print("four")
            sender.image = UIImage(named: "heart")
            deleteRecipeFromFavorites()
        }
    }
    
    
    func deleteRecipeFromFavorites() {
        
    }
}
