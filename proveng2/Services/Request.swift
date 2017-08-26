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
    
    case loginUser(gToken: String)
    case logoutUser(gToken: String)
    
    var parameters: [String: AnyObject] {
        switch self {
        //MARK: User
        case .loginUser, .logoutUser:
            return [:]
    }
    
    var path: String {
        switch self {
        //MARK: User
        case .loginUser:
            return "auth-by-google"
        case .logoutUser:
            return "logout"
    }
        
    var headers: [String: String]{
        let tokenKey = "token"
        switch self {
        case .loginUser:
            return [tokenKey: SessionData.token]
        default:
            return [tokenKey: SessionData.token]
        }
    }
    
    var body: String {
        let tokenKey = "gToken"
        switch self {
        case .loginUser(let gToken):
            let jsonBody: JSON =  [tokenKey: gToken]
            if let stringBody = jsonBody.rawString(){
                return stringBody
            } else {
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
    }
    
}

