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
        if sender.image == UIImage(named: "heart") {
            sender.image = UIImage(named: "fullHeart")
            coreDataManager?.addRecipeToFavorites(uri: recipeDetailsData[0][0].uri)
        } else if sender.image == UIImage(named: "fullHeart") {
            sender.image = UIImage(named: "heart")
            deleteRecipeFromFavorites()
        }
    }
    
    
    func deleteRecipeFromFavorites() {
        
    }
}
