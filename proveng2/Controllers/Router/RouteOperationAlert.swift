//
//  RouteOperationAlert.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

/**

 Show AlertViewController

 */
// RouterOperationAlert.showError

enum RouterOperationAlert {

    case showError(title: String,
        message: String,
        handler: AlertHandler)

    var alertController: UIAlertController {
        switch self {
        case .showError(var title,
                        var message,
                        var handler):
            if title == "Alamofire.AFError" {
                title = Constants.ErrorAlertTitle
                message = "Server is temporarily unavailable"
            } else if title.isEmpty ||
                title == "NSURLErrorDomain"{
                title = Constants.ErrorAlertTitle
            }
            if message.isEmpty {
                message = "Server error"
            }
            if title == "sessionError" {
                handler = { (alertAction: UIAlertAction) -> Void in
                    let promiseForLogout =
                        ServiceForData<Session>().deleteAllDataFromStoragePromise()
                    let promiseForDeletingTables = ServiceForData<EventPreview>().deleteTablesAfterLogoutPromise()
                    when(resolved: [promiseForLogout, promiseForDeletingTables]
                        ).always {
                            let operation = RouterOperationBack.backToLogin
                            self.alertController.router.performOperation(operation)
                        }.catch{ error in
                            print(error)
                    }
                }
            } else if title == "authError" {
                handler = { (alertAction: UIAlertAction) -> Void in
                    ServiceAuth().signOutWithGoogle({ result in
                        switch result {
                        case .success:
                            print("google sign out succes")
                        case .failure(let error):
                            print("google sign out error \(error)")
                        }
                    })
                }
            }
            return RouterOperationAlert.showAlert(title: title.capitalizingFirstLetter(), message: message.capitalizingFirstLetter(), style: .alert, cancelButtonTitle: nil, buttonTitles: [Constants.DefaultActionTitle], handler: handler).alertController
        }
    }
}

typealias AlertHandler = ((UIAlertAction) -> Void)?

