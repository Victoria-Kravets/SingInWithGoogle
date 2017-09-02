//
//  Session.swift
//  proveng2
//
//  Created by Artem Misesin on 8/26/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

// temporary structure to store data, retrieved after signing in with Google

class SingleSession {
    
    static let shared = SingleSession()
    
    var accessToken: String?
    var backendToken: String?
    var userId: Int?
    var teacher: Bool = false
    
    func clearSession() {
        accessToken = nil
        backendToken = nil
        userId = nil
        teacher = false
    }
    
}
