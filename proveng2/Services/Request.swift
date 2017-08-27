//
//  RequestType.swift
//  proveng2
//
//  Created by Artem Misesin on 8/26/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import Alamofire

/**
 Object encapsulates request parameters
 - Parameters:
 - parameters: param of request
 - path: url path of request
 - method: Alamofire.Method
 */
enum Request {
    
    case loginUser
    case logoutUser
    
    var parameters: [String: Any]? {
        switch self {
        case .loginUser, .logoutUser:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "auth-by-google"
        case .logoutUser:
            return "logout"
        }
    }
        
    var headers: [String: String] {
        let tokenKey = "token"
        switch self {
        case .loginUser:
            return [tokenKey: SessionData.token]
        default:
            return [tokenKey: SessionData.token]
        }
    }
    
    var body: String {
        switch self {
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginUser, .logoutUser:
            return .post
        }
    }
    
}
