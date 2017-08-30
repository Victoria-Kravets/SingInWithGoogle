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
            DataRequestService.shared.send(request: .loginUser).then { result in
                print(result)
            }
        }
    }
    
    @IBAction func signIn() {
        authService.signInExplicitlyWithPromise()
    }
    
    func signInSilently() {
        if authService.hasToken {
            firstly {
                self.authService.signInSilentlyWithPromise()
                }.then { _ in
                    self.attempt { DataRequestService.shared.send(request: .loginUser) }.then { result in
                        print(result)
                        
                        }.catch { error in
                            print(error.localizedDescription)
                    }
            }
        }
    }
    
    func attempt<T>(interdelay: DispatchTimeInterval = .seconds(2), maxRepeat: Int = 3, body: @escaping () -> Promise<T>) -> Promise<T> {
        var attempts = 0
        func attempt() -> Promise<T> {
            attempts += 1
            return body().recover { error -> Promise<T> in
                guard attempts < maxRepeat else { throw error }
                
                return after(interval: interdelay).then {
                    return attempt()
                }
            }
        }
        
        return attempt()
    }
}
