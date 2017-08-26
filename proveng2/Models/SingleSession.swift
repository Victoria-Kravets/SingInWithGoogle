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
    var idToken: String?
    var userId: String?
    
    func clearSession() {
        accessToken = nil
        idToken = nil
        userId = nil
    }
    
}
