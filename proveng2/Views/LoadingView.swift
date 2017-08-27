//
//  LoadingView.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//


import UIKit

class LoadingView: UIView {

    var activityIndicator: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.frame = frame
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.40)
        activityIndicator?.center = self.center
        self.addSubview(activityIndicator!)
        self.alpha = 1.0
        activityIndicator?.startAnimating()
    }

    func startIndicator() {
        activityIndicator?.startAnimating()
    }

    func stopIndicator() {
        activityIndicator?.stopAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

