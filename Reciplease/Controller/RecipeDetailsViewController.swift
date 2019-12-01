//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipeDetailsViewController: UIViewController {
    
    // Variables
    var coreDataManager: CoreDataManager?
    var recipeDetailsData: Hit?
    var favoriteRecipeDetailsData: FavoritesRecipesList?
    var isSegueFromFavoriteVc: Bool = true
    
    //Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTxtView: UITextView!
    @IBOutlet weak var favoritesIconButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        updateTheNavigationBar(navBarItem: navigationItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateTheView()
    }
}

// Update the view
extension RecipeDetailsViewController {
    
    func updateTheViewFromCoreData(){
        recipeTitleLabel.text = favoriteRecipeDetailsData?.name
        guard let imageData = favoriteRecipeDetailsData?.image else { return }
        recipeImageView.image = UIImage(data: imageData)
       // recipeImageView.load(url: urlImage)
        recipeIngredientsTxtView.text = favoriteRecipeDetailsData?.ingredients
    }
    
    func updateTheViewFromCallback(){
        recipeTitleLabel.text = recipeDetailsData?.recipe?.label
        guard let urlImage = URL(string: recipeDetailsData?.recipe?.image ?? "") else { return }
        recipeImageView.load(url: urlImage)
        guard let ingredientsArray = recipeDetailsData?.recipe?.ingredientLines else {return}
        recipeIngredientsTxtView.text = "-" + " " + ingredientsArray.joined(separator: "\n\n" + "-" + " ")
    }
    
    
    func updateTheView() {
        if isSegueFromFavoriteVc == false {
            updateTheViewFromCallback()
        } else if isSegueFromFavoriteVc == true {
            updateTheViewFromCoreData()
        }
        guard coreDataManager?.checkIfRecipeIsAlreadyFavorite(recipeName: recipeTitleLabel.text ?? "") == true else {
            favoritesIconButton.image = UIImage(named: "heart")
            return }
        favoritesIconButton.image = UIImage(named: "fullHeart")
    }
}

// Actions
extension RecipeDetailsViewController {
    
    @IBAction func didTapGetDirectionsButton(_ sender: Any) {
        if isSegueFromFavoriteVc == false {
            guard let directionsUrl = URL(string: recipeDetailsData?.recipe?.url ?? "") else {return}
            UIApplication.shared.open(directionsUrl)
        } else if isSegueFromFavoriteVc == true {
            guard let directionsUrl = URL(string: favoriteRecipeDetailsData?.recipeUrl ?? "") else {return}
            UIApplication.shared.open(directionsUrl)
        }
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "heart") {
            sender.image = UIImage(named: "fullHeart")
            addRecipeToFavorites()
        } else if sender.image == UIImage(named: "fullHeart") {
            sender.image = UIImage(named: "heart")
            deleteRecipeFromFavorites()
        }
    }
    
    func deleteRecipeFromFavorites(){
        if isSegueFromFavoriteVc == false {
            coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeTitleLabel.text ?? "")
        } else if isSegueFromFavoriteVc == true {
            coreDataManager?.deleteRecipeFromFavorite(recipeName: recipeTitleLabel.text ?? "")
            navigationController?.popViewController(animated: true)
        }
    }
    
    func addRecipeToFavorites() {
        if isSegueFromFavoriteVc == false {
            guard let name = recipeDetailsData?.recipe?.label, let image = recipeDetailsData?.recipe?.image, let ingredientArray = recipeDetailsData?.recipe?.ingredientLines, let url = recipeDetailsData?.recipe?.url, let time = recipeDetailsData?.recipe?.totalTime else { return}
            coreDataManager?.addRecipeToFavorites(name: name, image: obtainImageDataFromUl(stringImageUrl: image), ingredientsDescription: "-" + " " + ingredientArray.joined(separator: "\n\n" + "-" + " "), recipeUrl: url, time: String(time))
        } else if isSegueFromFavoriteVc == true {
            guard let name = favoriteRecipeDetailsData?.name else { return }
            coreDataManager?.addRecipeToFavorites(name: name, image: favoriteRecipeDetailsData?.image ?? Data(), ingredientsDescription: favoriteRecipeDetailsData?.ingredients ?? "", recipeUrl: favoriteRecipeDetailsData?.recipeUrl ?? "", time: favoriteRecipeDetailsData?.totalTime ?? "")
        }
    }
    
    func obtainImageDataFromUl(stringImageUrl: String) -> Data{
        guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
        guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
        return data
    }
}

////data from url
//func obtainImageDataFromUrl() -> {
//    let stringImageUrl = ""
//    guard let imageUrl = URL(string: stringImageUrl) else {return}
//    guard let data = try? Data(contentsOf: imageUrl) else {return}
//    return data
//}
