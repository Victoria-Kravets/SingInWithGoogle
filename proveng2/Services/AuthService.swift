//
//  AuthService.swift
//  proveng2
//
//  Created by Artem Misesin on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import GoogleSignIn
import PromiseKit

class AuthService: NSObject {

    fileprivate let GIDService = GIDSignIn.sharedInstance()
    fileprivate var authError: AuthError?
    
    var hasToken: Bool {
        return GIDSignIn.sharedInstance().hasAuthInKeychain()
    }
    
    override init() {
        super.init()
        GIDService!.delegate = self
    }
    
    func signInExplicitlyWithPromise() -> Promise<AuthResult> {
        return Promise { fulfill, reject in
            GIDService?.signIn()
            guard authError == nil else {
                reject(authError!)
                return
            }
            fulfill(.success)
        }
    }
    
    @discardableResult func signInSilentlyWithPromise() -> Promise<AuthResult> {
        return Promise { fulfill, reject in
            GIDService?.signInSilently()
            guard authError == nil else {
                reject(authError!)
                return
            }
            fulfill(.success)
        }
    }
    
    @discardableResult func googleSignOut() -> Promise<AuthResult> {
        return Promise { fulfill, reject in
            guard authError == nil else {
                reject(authError!)
                return
            }
        fulfill(.success)
        }
    }
    
}

extension AuthService: GIDSignInDelegate {

    // If delegate methods run into errors,
    // it's gonna be stored as a AuthService property
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard user != nil else {
            authError = .noToken
            return
        }
        
        guard error == nil else {
            authError = .unknownError
            return
        }
        
        SingleSession.shared.idToken = user.authentication.idToken
        SingleSession.shared.accessToken = user.authentication.accessToken

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        guard signIn != nil else {
            authError = .noHandlersInstalled
            return
        }
        
        guard user != nil else {
            authError = .noToken
            return
        }
        
        guard error == nil else {
            authError = .unknownError
            return
        }
        
        SingleSession.shared.clearSession()
    }

}
