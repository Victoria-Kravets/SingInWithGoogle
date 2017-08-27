//
//  BaseViewController.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit
import PromiseKit

class BaseViewController: UIViewController, BaseViewControllerProtocol,
UINavigationBarDelegate, BaseLoadViewProtocol {

    func handleError(error: Error) {
        guard error.apiError.code != 403 else {
            return
        }
        var errorTitle = error.apiError.domain
        if error.apiError.code == 404 {
            errorTitle = "Error"
        }
        let operation = RouterOperationAlert.showError(title: errorTitle,
                                                       message:
            error.apiError.errorDescription,
                                                       handler: nil)
        _ = self.router.performOperation(operation as! RouteOperation)
    }

    func hideLoadingView() {
        var loadView: LoadingView? = self.navigationController?.view.subviews.last as? LoadingView
        guard let subviews = self.navigationController?.view.subviews else {
            return
        }
        for view in subviews {
            if view is LoadingView {
                loadView = view as? LoadingView
            }
        }
        self.navigationController?.view.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        loadView?.removeFromSuperview()
        loadView?.stopIndicator()
    }

    func checkUserType(type: Bool, user: User) {
        SessionData.teacher = type
        let role = user.role.filter("name == %@",
                                    UserRoleType.student.rawValue)
        if type {
            self.presentHomeScreenVC(teacher: type)
        } else if role.count > 0 {
            self.presentHomeScreenVC(teacher: false)
        } else {
            self.requestTests()
        }
        self.appDelegate.setupBaseAppearance()
        self.navigationController?.navigationBar.barTintColor = ColorForElements.main.color//Important
    }
    
}
