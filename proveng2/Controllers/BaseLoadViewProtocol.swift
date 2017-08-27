//
//  BaseLoadViewProtocol.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit

protocol BaseLoadViewProtocol { }

extension BaseLoadViewProtocol where Self: UIViewController {

    func showLoadingView() {
        let loadView = LoadingView(frame: self.view.bounds)
        self.navigationController?.view.addSubview(loadView)
        self.navigationController?.view.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        loadView.startIndicator()
    }
    
}
