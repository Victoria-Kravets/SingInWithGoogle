//
//  RequestError.swift
//  proveng2
//
//  Created by Artem Misesin on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case dataError
    case jsonError
    case unsupportedError
    case tokenError
}
