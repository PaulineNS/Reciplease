//
//  MockSearchSession.swift
//  RecipleaseTests
//
//  Created by Pauline Nomballais on 15/11/2019.
//  Copyright © 2019 PaulineNomballais. All rights reserved.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockSearchSession: AlamoSession {
    
    // MARK: - Properties
    
    private let fakeResponse: FakeResponse
    
    // MARK: - Initializer
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
        callBack(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
