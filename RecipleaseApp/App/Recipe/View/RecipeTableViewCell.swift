//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeTimeLabel: UILabel!
    
    // MARK: - Variables
    
    var recipe: RecipeItem? {
        didSet {
            recipeTitleLabel.text = recipe?.name
            recipeImageView.image = UIImage(data: recipe?.image ?? Data())
            guard recipe?.time != "0" else {
                recipeTimeLabel.isHidden = true
                return
            }
            recipeTimeLabel.isHidden = false
            recipeTimeLabel.text = recipe?.time
        }
    }
}
