//
//  RouteOperationBack.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

enum RouterOperationBack {

    case backToLogin
    case backToTestPreview(testID: Int)
    case close
    case backToHome

    func baseViewController(_ router:Router) -> BaseViewControllerProtocol? {
        switch self {
        case .backToLogin:
            if let loginVC = router.viewControllerWithType(LoginViewController.self) as? BaseViewControllerProtocol {
                return loginVC
            } else {
                let operation = RouterOperationXib.openLogin
                router.performOperation(operation)
                if let loginVC = (router.navigationController?.viewControllers.last) as? LoginViewController {
                    return loginVC
                }
                return nil
            }
        }
    }
}
