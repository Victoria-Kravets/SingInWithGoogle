//
//  LoginViewController.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var rulesLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: BaseButton! // Has to be GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }

}
