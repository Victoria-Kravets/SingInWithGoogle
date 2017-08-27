//
//  UIViewController+chekInternetConnection.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit
extension UIViewController {
    func chekInternetConnection() -> Bool {
        guard Reachability.isConnectedToNetwork() else {
            let operation = RouterOperationAlert.showError(title: Constants.ErrorAlertTitle, message: Constants.LostInternetConectionAlertMessage, handler: nil)
            self.router.performOperation(operation)
            return false
        }
        return true
    }
}
