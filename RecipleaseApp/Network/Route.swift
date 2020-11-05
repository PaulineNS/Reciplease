//
//  Route.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 02/11/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import UIKit

final class Route {
    
    let applicationId = "e6b49d48"
    let apiKey = "c2809da35956f6fb80d5a86c46199b6b"
    
    func getURL (ingredients: String,
                 health: String) -> URL? {
        let urlAdress = "https://api.edamam.com/search?q=\(ingredients + health)&app_id=\(applicationId)&app_key=\(apiKey)"
        
        guard let urlString = urlAdress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
