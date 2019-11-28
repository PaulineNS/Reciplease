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
    var favoriteRecipeDetailsData: FavoritesRecipesList?
    var isSegueFromFavoriteVc: Bool = true
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTxtView: UITextView!
    @IBOutlet weak var favoritesIconButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updateTheView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    func updateTheView() {
        if isSegueFromFavoriteVc == false {
            recipeTitleLabel.text = recipeDetailsData[0][0].label
            guard let urlImage = URL(string: recipeDetailsData[0][0].image) else { return }
            recipeImageView.load(url: urlImage)
            recipeIngredientsTxtView.text = "-" + " " + recipeDetailsData[0][0].ingredientLines.joined(separator: "\n\n" + "-" + " " )
            
        } else if isSegueFromFavoriteVc == true {
            recipeTitleLabel.text = favoriteRecipeDetailsData?.name
            guard let urlImage = URL(string: favoriteRecipeDetailsData?.image ?? "") else { return }
            recipeImageView.load(url: urlImage)
            recipeIngredientsTxtView.text = favoriteRecipeDetailsData?.ingredients
        }
        guard coreDataManager?.checkIfRecipeIsAlreadyFavorite(recipeName: recipeTitleLabel.text ?? "") == true else {
            favoritesIconButton.image = UIImage(named: "heart")
            return }
        favoritesIconButton.image = UIImage(named: "fullHeart")
    }
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        if isSegueFromFavoriteVc == false {
        guard let directionsUrl = URL(string: recipeDetailsData[0][0].url) else {return}
        UIApplication.shared.open(directionsUrl)
        } else if isSegueFromFavoriteVc == true {
            guard let directionsUrl = URL(string: favoriteRecipeDetailsData?.recipeUrl ?? "") else {return}
            UIApplication.shared.open(directionsUrl)
        }
 }
    
    @IBAction func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "heart") {
            sender.image = UIImage(named: "fullHeart")
            if isSegueFromFavoriteVc == false {
                guard let name = recipeDetailsData[0][0].label else { return}
                coreDataManager?.addRecipeToFavorites(name: name, image: recipeDetailsData[0][0].image, ingredientsDescription: "-" + " " + recipeDetailsData[0][0].ingredientLines.joined(separator: "\n\n" + "-" + " "), recipeUrl: recipeDetailsData[0][0].url)
            } else if isSegueFromFavoriteVc == true {
                guard let name = favoriteRecipeDetailsData?.name else { return }
                coreDataManager?.addRecipeToFavorites(name: name, image: favoriteRecipeDetailsData?.image ?? "", ingredientsDescription: favoriteRecipeDetailsData?.ingredients ?? "", recipeUrl: favoriteRecipeDetailsData?.recipeUrl ?? "")
            }
        } else if sender.image == UIImage(named: "fullHeart") {
            sender.image = UIImage(named: "heart")
            coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeTitleLabel.text ?? "")
            
        }
    }
}
