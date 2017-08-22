//
//  BaseButton.swift
//  proveng2
//
//  Created by pavel on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit

@IBDesignable

class BaseButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.backgroundColor = ColorForElements.main.color
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
    }

}
