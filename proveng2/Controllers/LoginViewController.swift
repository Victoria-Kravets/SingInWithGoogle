//
//  LoginViewController.swift
//  proveng2
//
//  Created by pavel on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseViewController, GIDSignInUIDelegate {
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var rulesLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    lazy var serviceAuth = ServiceAuth()
    lazy var serviceRequest = ServiceForRequest<User>()
    let googleSignIn = GIDSignIn.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.googleSignIn?.uiDelegate = self
    }


}
