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
    
    
    // var recipe: dataRecu
    var recipe: Hit? {
        didSet {
            recipeTitleLabel.text = recipe?.recipe?.label
            if let stringUrl = recipe?.recipe?.image {
                guard let imageUrl = URL(string: stringUrl) else {return}
                guard let data = try? Data(contentsOf: imageUrl) else {return}
                recipeImageView.image = UIImage(data: data)
                //recipeImageView.load(url: stringUrl)
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


//guard let imageUrl = URL(string: stringImageUrl) else {return Data()}
//guard let data = try? Data(contentsOf: imageUrl) else {return Data()}
//return data
