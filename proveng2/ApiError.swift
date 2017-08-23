//
//  ApiError.swift
//  proveng2
//
//  Created by Viktoria on 8/23/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

class ApiError: Error {
    init(errorDescription: String) {
        print(errorDescription)
    }
}
