//
//  AlertType.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

enum AlertType: Equatable {
    case networkError
    case noIngredients
    case noRecipesFound
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "😲",
                         message: "Please try again later...")
        case .noIngredients:
            self = Alert(title: "😲",
                         message: "You have to enter at least 1 ingredient")
        case .noRecipesFound:
            self = Alert(title: "Oups",
                         message: "No recipes found")
        }
    }
}
