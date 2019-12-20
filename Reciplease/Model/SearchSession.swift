//
//  SearchSession.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 13/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class SearchSession: RequestSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}


