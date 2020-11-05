//
//  RecipeItem.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

public struct RecipeItem: Equatable {
    let name: String
    var image: Data
    let url: String
    let ingredients: String
    let time: String
}
