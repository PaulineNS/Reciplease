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
    
    // Cell Configuration
    func configure(title: String, pictureUrl: URL){
        recipeTitleLabel.text = title
        recipeImageView.load(url: pictureUrl)
    }
}
