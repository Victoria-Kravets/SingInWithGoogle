//
//  RouteOperation.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
enum RouterOperationXib {
    // MARK: User

    case openLogin

    var baseViewController: BaseViewControllerProtocol {
        switch self {
            case .openLogin:
            return LoginViewController(nibName: xibName, bundle: nil)
        }
    }


    var xibName: String {
        switch self {
        // MARK: User
        case .openLogin:
            return "LoginViewController"
        }
    }
}
