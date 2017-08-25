//
//  AuthError.swift
//  proveng2
//
//  Created by Artem Misesin on 8/24/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case noToken
    case unknownError
    case keychainError
    case noHandlersInstalled
    case noAuthInKeychain
    case canceled
}
