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
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void)
}

final class SearchSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}


