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
        guard let operation = RouterOperationAlert.showError(title: Constants.ErrorAlertTitle, message: Constants.LostInternetConectionAlertMessage, handler: nil)
            as? RouteOperation else {
                fatalError("Can not conver RouterOperationAlert to RouteOperation")
        }
        guard Reachability.isConnectedToNetwork() else {
            self.router.performOperation(operation)
            return false
        }
        return true
    }
}
