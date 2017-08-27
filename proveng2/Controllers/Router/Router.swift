//
//  Router.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//


import UIKit

class Router {

    weak var navigationController: UINavigationController?
    weak var tabBarViewController: UITabBarController?
    var loginVC: LoginViewController?

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /**

     Show ViewController

     */

    @discardableResult func performOperation(_ routeOperation:RouteOperation) -> BaseViewControllerProtocol? {
        return routeOperation.startOperation(self)
    }

}

extension Router {
    func viewControllerWithType<T>(_ viewControllerType: T.Type) -> UIViewController? {
        return self.navigationController?.viewControllers.filter({
            (viewController: UIViewController) in return type(of: viewController) ==
            viewControllerType}).first
    }
}

