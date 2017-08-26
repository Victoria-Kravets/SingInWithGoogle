//
//  AuthError.swift
//  proveng2
//
//  Created by Artem Misesin on 8/24/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

// all possible GoogleSignIn errors, not sure about this error handling approach

enum AuthError: Error {
    case noToken
    case unknownError
    case keychainError
    case noHandlersInstalled
    case noAuthInKeychain
    case canceled
}

// Don't need this probably,
// but I don't know what to return in a promise
// when I just need to know if it's resolved

enum AuthResult {
    case success
}
