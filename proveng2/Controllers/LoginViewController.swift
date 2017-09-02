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
    @IBOutlet weak var authSpinner: UIActivityIndicatorView!
    
    let GIDService = GIDSignIn.sharedInstance()
    let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDService?.uiDelegate = self
        GIDService?.signOut() // for development purposes
        signInSilently()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if SingleSession.shared.accessToken != nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.authSpinner.startAnimating()
            self.loginButton.isEnabled = false
            DataRequestService.shared.send(request: .loginUser).then { data -> Void in
                self.mapAuthResult(from: data)
                }.always {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.authSpinner.stopAnimating()
                    self.loginButton.isEnabled = true
                }.catch { error in
                    print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func signIn() {
        if Connection.isAvailable {
            authService.signInExplicitlyWithPromise().catch { error in
                let apiError = error.apiError
                self.showAlert(title: "Error", description: apiError.description)
            }
        } else {
            self.showAlert(title: "Error", description: "Internet connection is not available")
        }
    }
    
    private func signInSilently() {
        if authService.hasToken {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.authSpinner.startAnimating()
            self.loginButton.isEnabled = false
            firstly {
                self.authService.signInSilentlyWithPromise()
                }.then { _ in
                    self.authService.attempt { DataRequestService.shared.send(request: .loginUser) }.then { data in
                        self.mapAuthResult(from: data)
                    }
                }.always {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.authSpinner.stopAnimating()
                    self.loginButton.isEnabled = true
                }.catch { error in
                    print(error.localizedDescription)
            }
        }
    }
    
    private func mapAuthResult(from data: String) {
        if let mappedResult = AuthResult(JSONString: data) {
            if mappedResult.description != nil {
                self.showAlert(title: "Error", description: mappedResult.description!)
                GIDService?.signOut()
            } else if mappedResult.result != nil {
                SingleSession.shared.backendToken = mappedResult.token
                SingleSession.shared.userId = mappedResult.userId
                // TODO: perform segue to the next screen
            }
        }
    }
    
    private func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
