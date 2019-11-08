//
//  RecipeService.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 08/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

final class RecipeService {
    
    var recipeData = [Recipe]()
    
    //MARK: VARIABLES
    private var task: URLSessionDataTask?
    private var session: URLSession
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    /// Getting Data
    func getRecipe(ingredients: String, callback: @escaping (Result <Recipe, NetworkError>) -> Void) {
        // compose url endpoint
        guard let recipeUrl = URL(string: "https://api.edamam.com/search?q=\(ingredients)&app_id=e6b49d48&app_key=c2809da35956f6fb80d5a86c46199b6b") else { return }
        
        task?.cancel()
        task = session.dataTask(with: recipeUrl) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    callback(.failure(.badUrl))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.network))
                    return
                }
                
                // lecture JSON
                guard let responseJSON = try? JSONDecoder().decode(Recipe.self, from: data) else {
                    callback(.failure(.invalidData))
                    return
                }
                
                callback(.success(responseJSON))
            }
        }
        
        task?.resume()
    }
} // end class
