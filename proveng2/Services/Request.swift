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
    case getUserProfile(userId: Int)
    
    var parameters: [String: Any]? {
        let tokenKey = "gToken"
        let IdKey = "id"
        switch self {
        case .loginUser, .logoutUser:
            return [tokenKey: SingleSession.shared.accessToken ?? ""]
        case .getUserProfile(let userId):
            return [IdKey: userId]
            
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "auth-by-google"
        case .logoutUser:
            return "logout"
        case .getUserProfile:
            return "user"
        }
    }
        
    var headers: [String: String] {
        let tokenKey = "gToken"
        switch self {
        default:
            return [:]
        }
    }
    
    var body: String {
        let tokenKey = "gToken"
        switch self {
        case .loginUser:
            let jsonBody =  [tokenKey: SingleSession.shared.accessToken ?? ""]
            do {
                let jsonData: Data = try JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
                return String(data: jsonData, encoding: .utf8)!
            } catch {
                return ""
            }
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .loginUser, .logoutUser:
            return .post
        case .getUserProfile:
            return .get
        }
    }
    
}
