//
//  Dictionary.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            guard let key = key as? String else {
                fatalError("Can not convert key to String")
            }
            let percentEscapedKey = (key).stringByAddingPercentEncodingForURLQueryValue()!
            let stringValue = String(describing: value)
            let percentEscapedValue = stringValue.stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
}
