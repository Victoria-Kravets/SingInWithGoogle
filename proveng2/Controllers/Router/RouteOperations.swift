//
//  RouteOperations.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit

extension UIViewController {
    var router: Router {
        guard let app = UIApplication.shared.delegate as? AppDelegate,
            let router = app.router else {
            fatalError("Can not get router")
        }
        return router
    }
}

protocol BaseViewControllerProtocol {

}

protocol RouteOperation {
    func startOperation(_ router: Router) -> BaseViewControllerProtocol?
}



