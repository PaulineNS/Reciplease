//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    
    var recipe: Hit? {
        didSet {
            recipeTitleLabel.text = recipe?.recipe?.label
            if let stringUrl = URL(string: recipe?.recipe?.image ?? "") {
                recipeImageView.load(url: stringUrl)
            }
            recipeTimeLabel.text = recipe?.recipe?.totalTime?.convertIntToTime
        }
    }
    
    // Cell Configuration
    func configure(title: String, pictureUrl: URL, time: String){
        recipeTitleLabel.text = title
        recipeImageView.load(url: pictureUrl)
        recipeTimeLabel.text = time
    }
}
