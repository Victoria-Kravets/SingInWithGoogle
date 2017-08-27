//
//  LoginViewController.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit
import PromiseKit
import RealmSwift
import GoogleSignIn

class LoginViewController: BaseViewController, GIDSignInUIDelegate {
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var rulesLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    let googleSignIn = GIDSignIn.sharedInstance()
    lazy var serviceAuth = ServiceAuth()
    lazy var serviceRequest = ServiceForRequest<User>()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let googleSignIn = googleSignIn else {
            fatalError("googleSignIn is nil")
        }
        googleSignIn.uiDelegate = self
    }

    func requestUser(session: Session, completion: @escaping () -> Void) {
        let getLocationPromise = ServiceForRequest<Location>().getObjectsPromise(ApiMethod.getLocations)
            .asVoid()
        let getDepartmentPromise = ServiceForRequest<Department>().getObjectsPromise(ApiMethod.getDepartments)
            .asVoid()
        let getLevelsPromise = ServiceForRequest<GroupLevelPreview>().getObjectsPromise(ApiMethod.getLevels)
            .asVoid()
        let apiMethod = ApiMethod.getUserProfile(userID: session.userID)
        when(resolved: [getLocationPromise, getDepartmentPromise, getLevelsPromise])
            .then { _ -> Promise<User> in
            return self.serviceRequest.getObjectPromise(apiMethod)
            }.then{ [weak self] user -> Void in
                let realm = try Realm()
                let currentSession = Session()
                currentSession.objectID = 1
                currentSession.token = session.token
                currentSession.userID = session.userID
                currentSession.currentUser = user
                try realm.write{
                    realm.add(currentSession, update: true)
                }
                self?.checkUserType(type: user.userIsTeacher(), user: user)
            }.always { [weak self] in
                self?.hideLoadingView()
                completion()
            }.catch { [weak self] error in
                guard let operation = RouterOperationAlert.showError(
                    title: error.apiError.domain,
                    message: error.apiError.errorDescription,
                    handler: nil) as? RouteOperation else {
                        fatalError("Can not convert RouterOperationAlert to RouteOperation")
                }
                _ = self?.router.performOperation(operation)
        }
    }

    //MARK: - Actions
    @IBAction func loginUserButtonPressed(_ sender: AnyObject) {
        if !chekInternetConnection() {
            return
        }
        self.loginButton.isEnabled = false
        //self.showLoadingView()
        self.showLoadingView()
        self.serviceAuth.signInWithGoogle({ [weak self] result in
            switch result {
            case .success(let value):
                if let session: Session = value as? Session, let token = session.token {
                    SessionData.token = token
                    SessionData.id = session.userID
                    self?.requestUser(session: session, completion: {
                        self?.loginButton.isEnabled = true
                    })
                } else {
                    self?.hideLoadingView()
                    print("ERROR - Value as not Session")
                }
            case .failure(let error):
                let apiError = error.apiError
                print("error \(error)")
                if apiError.code != -5 {
                    self?.handleError(error: error)
                }
                self?.loginButton.isEnabled = true
                self?.hideLoadingView()
            }
        })
    }
    
}
