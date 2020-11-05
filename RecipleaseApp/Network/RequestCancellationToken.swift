//
//  RequestCancellationToken.swift
//  Reciplease
//
//  Created by Pauline Nomballais on 27/10/2020.
//  Copyright © 2020 PaulineNomballais. All rights reserved.
//

import Foundation

final class RequestCancellationToken {

    init() {}

    var willDealocate: (() -> Void)?

    deinit {
        willDealocate?()
    }
}
