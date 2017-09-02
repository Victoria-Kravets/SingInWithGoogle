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
    fileprivate var authError: ApiError?
    
    var hasToken: Bool {
        return GIDSignIn.sharedInstance().hasAuthInKeychain()
    }
    
    override init() {
        super.init()
        GIDService!.delegate = self
    }
    
    func signInExplicitlyWithPromise() -> Promise<String> {
        return Promise { fulfill, reject in
            GIDService?.signIn()
            guard authError == nil else {
                reject(authError!)
                return
            }
            fulfill("Success")
        }
    }
    
    @discardableResult func signInSilentlyWithPromise() -> Promise<String> {
        return Promise { fulfill, reject in
            GIDService?.signInSilently()
            guard authError == nil else {
                reject(authError!)
                return
            }
            fulfill("Success")
        }
    }
    
    @discardableResult func googleSignOut() -> Promise<String> {
        return Promise { fulfill, reject in
            guard authError == nil else {
                reject(authError!)
                return
            }
        fulfill("Success")
        }
    }
    
    func attempt<T>(interdelay: DispatchTimeInterval = .seconds(1), maxRepeat: Int = 5, body: @escaping () -> Promise<T>) -> Promise<T> {
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

extension AuthService: GIDSignInDelegate {

    // If delegate methods run into errors,
    // it's gonna be stored as a AuthService property
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            authError = ApiError(description: error.localizedDescription)
            return
        }
        
        SingleSession.shared.accessToken = user.authentication.accessToken

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            authError = ApiError(description: error.localizedDescription)
            return
        }
        
        SingleSession.shared.clearSession()
    }

}
