//
//  LoginViewController.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import PromiseKit
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var rulesLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!

    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        signInSilently()
    }
    
    @IBAction func signIn() {
        firstly {
            authService.signInExplicitlyWithPromise()
            }.then { session in
                print(session.idToken)
            }.catch {
                print($0.localizedDescription)
        }
    }
    
    func signInSilently() {
        if !authService.hasToken {
            firstly {
                authService.signInSilentlyWithPromise()
                }.then { session in
                        print(session.idToken)
                }.catch {
                    print($0.localizedDescription)
            }
        }
    }

}
