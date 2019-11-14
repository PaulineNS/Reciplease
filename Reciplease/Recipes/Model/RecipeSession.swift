//
//  SearchSession.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 13/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any, Error>) -> Void)
}

final class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any, Error>) -> Void) {
        AF.request(url).responseJSON { responseData in
            switch responseData.result {
            case .success(let data) :
                callBack (data as! DataResponse<Any, Error>)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


