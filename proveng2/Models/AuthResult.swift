//
//  Result.swift
//  proveng2
//
//  Created by Artem Misesin on 9/1/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthResult: Mappable {
    
    var result: Any?
    var token: String?
    var userId: Int?
    var error: Any?
    var code: Int?
    var description: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        token <- map["result.token"]
        userId <- map["result.userId"]
        error <- map["error"]
        code <- map["error.code"]
        description <- map["error.description"]
    }
    
}
