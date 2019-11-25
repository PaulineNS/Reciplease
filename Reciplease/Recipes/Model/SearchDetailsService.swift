//
//  SearchDetailsService.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 25/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation

final class SearchDetailsService {
    
    var searchData = [[RecipeDetail]()]
    
    private let session: AlamoSession
    
    init(session: AlamoSession = SearchSession()) {
        self.session = session
    }
    
    func getRecipeDetails(recipeId: String, callback: @escaping (Result<[RecipeDetail], Error>) -> Void) {
        guard let recipeIdwithAllowedCharacters = recipeId.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.edamam.com/search?r=\(recipeIdwithAllowedCharacters)&app_id=e6b49d48&app_key=c2809da35956f6fb80d5a86c46199b6b") else { return }
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                print ("no data")
                callback(.failure(NetworkError.noData))
                return
            }
            guard responseData.response?.statusCode == 200 else {
                print ("bad status code")
                callback(.failure(NetworkError.incorrectResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode([RecipeDetail].self, from: data) else {
                print ("no json")
                callback(.failure(NetworkError.undecodable))
                return
            }
            callback(.success(dataDecoded))
            self.searchData = [dataDecoded]
            
        }
    }
}
